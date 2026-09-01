# description: Adds Google OAuth2 sign-in via Devise omniauthable (requires devise module)
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"

run "bundle install"

rails_command "g migration add_omniauth_to_users provider:string uid:string name:string image:string"

# Add :omniauthable to existing User devise modules
inject_into_file "app/models/user.rb", after: /devise :.+\n.+/, force: true do
  ", :omniauthable, omniauth_providers: [:google_oauth2]"
end

# Add from_omniauth class method to User
inject_into_file "app/models/user.rb", before: /^end/ do
  <<-RUBY
  \n  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.image = auth.info.image
      user.terms_and_conditions = true
      user.skip_confirmation! if user.respond_to?(:skip_confirmation!)
    end
  end
  RUBY
end

# Wire up omniauth controllers on existing devise_for route
gsub_file "config/routes.rb",
  /devise_for :users(?!.*controllers)/,
  'devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }'

copy_file File.join(File.expand_path("..", __dir__), "files/app/controllers/users/omniauth_callbacks_controller.rb"),
  "app/controllers/users/omniauth_callbacks_controller.rb"

# Configure omniauth provider — reads credentials per-env
append_to_file "config/initializers/devise.rb" do
  <<-RUBY
\n
Rails.application.config.to_prepare do
  google_creds = Rails.application.credentials.google_oauth2 || {}
  if google_creds[:client_id].present? && google_creds[:client_secret].present?
    Devise.setup do |config|
      config.omniauth :google_oauth2,
        google_creds[:client_id],
        google_creds[:client_secret],
        scope: "email,profile",
        prompt: "select_account",
        image_aspect_ratio: "square",
        image_size: 200
    end
  end
end
  RUBY
end

say "\nAdd google_oauth2 credentials per-env, e.g.:", :yellow
say "  bin/rails credentials:edit --environment development", :yellow
say "  google_oauth2:\n    client_id: YOUR_CLIENT_ID\n    client_secret: YOUR_CLIENT_SECRET", :yellow
