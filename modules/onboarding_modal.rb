# Adds a modal partial and a pattern to open it after sign up with confetti to onboard a user

copy_file File.join(File.expand_path("..", __dir__), "files/app/views/shared/_modal.html.erb"), 
  "app/views/shared/_modal.html.erb"

copy_file File.join(File.expand_path("..", __dir__), "files/app/javascript/controllers/modal_controller.js"), 
  "app/javascript/controllers/modal_controller.js"

# Install confetti js package

copy_file File.join(File.expand_path("..", __dir__), "files/app/javascript/controllers/confetti_controller.js"), 
  "app/javascript/controllers/confetti_controller.js"

after_bundle do
  run "bun install canvas-confetti"
  rails_command "stimulus:manifest:update"
end

# Create onboarding controller

rails_command "g controller onboarding index"

gsub_file "config/routes.rb", "get \"onboarding/index\"", "get \"/onboarding\", to: \"onboarding#index\", as: \"onboarding\"" 

inject_into_file "app/controllers/onboarding_controller.rb", after: "def index\n" do
  "   session[:onboarding] = nil # Remove modal as soon as the first screen has been seen by the user\n"
end

copy_file File.join(File.expand_path("..", __dir__), "files/app/views/onboarding/index.html.erb"), 
  "app/views/onboarding/index.html.erb", force: true

# Create registration controller for devise

copy_file File.join(File.expand_path("..", __dir__), "files/app/controllers/users/registrations_controller.rb"), 
  "app/controllers/users/registrations_controller.rb"

# Amend routes to use registrations controller

gsub_file "config/routes.rb", "devise_for :users", 
<<-eos 
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
eos
