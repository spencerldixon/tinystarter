gem "devise"
run "bundle install"
rails_command("g devise:install")
rails_command("g devise User")
rails_command "g migration add_admin_to_user"

inject_into_file Dir.glob("db/migrate/*_add_admin_to_user.rb").first, after: "def change" do
  "\n\t\tadd_column :users, :admin, :boolean, default: false"
end

inject_into_file "app/models/user.rb", before: "end" do
  <<-eos
  \n\t# Add terms and conditions validation on create
  attr_accessor :terms_and_conditions
  validates_acceptance_of :terms_and_conditions, allow_nil: false, on: :create
  eos
end

devise_modules = ["lockable", "confirmable", "trackable"]

lockable_text = <<-eos
      t.integer  :failed_attempts, default: 0, null: false
      t.string   :unlock_token
      t.datetime :locked_at
      add_index :users, :unlock_token,         unique: true
eos

trackable_text = <<-eos
      Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
eos

confirmable_text = <<-eos
      Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable
      add_index :users, :confirmation_token,   unique: true
eos

devise_modules.each do |module_name|
  inject_into_file "app/models/user.rb", after: /devise :.+\n.+/, force: true do
    ", :#{module_name}"
  end
end

[lockable_text, trackable_text, confirmable_text].each do |migration_text|
  # Uncomment lines from devise migration
  migration_text.lines.each do |line|
    uncomment_lines Dir.glob("db/migrate/*_devise_create_users.rb").first, line.strip
  end
end

# Add authenticated root

inject_into_file "config/routes.rb", after: /devise_for :users/, force: true do
  <<-eos
  \ndevise_scope :user do
    unauthenticated do
      root to: "devise/sessions#new"
    end

    authenticated do
      root to: "dashboard#index", as: :authenticated_root
    end
  end\n
  eos
end

# Copy over devise layouts
directory File.join(File.expand_path("..", __dir__), "files/app/views/devise"), "app/views/devise"

# Alternatively, generate your own...
# rails_command("g devise:views")

# Add :authenticate_user! to application controller and permit :terms_and_conditions on sign up
inject_into_file "app/controllers/application_controller.rb", before: /end/, force: true do
  <<-eos
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:terms_and_conditions])
  end
  eos
end

append_to_file "config/initializers/devise.rb" do
  <<-eos
\n
Rails.application.config.to_prepare do
  Devise::SessionsController.layout "devise"
  Devise::RegistrationsController.layout proc { |controller| user_signed_in? ? "application" : "devise" }
  Devise::ConfirmationsController.layout "devise"
  Devise::UnlocksController.layout "devise"
  Devise::PasswordsController.layout "devise"
end
  eos
end

# Allow unconfirmed access

uncomment_lines "config/initializers/devise.rb", "config.allow_unconfirmed_access_for = 2.days"
