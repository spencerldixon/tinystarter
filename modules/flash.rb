copy_file File.join(File.expand_path("..", __dir__), "files/app/views/shared/_flash.html.erb"), 
  "app/views/shared/_flash.html.erb"

copy_file File.join(File.expand_path("..", __dir__), "files/app/helpers/flash_helper.rb"), 
  "app/helpers/flash_helper.rb"

# Copy flash stimulus controller
copy_file File.join(File.expand_path("..", __dir__), "files/app/javascript/controllers/flash_controller.js"), 
  "app/javascript/controllers/flash_controller.js"

rails_command "stimulus:manifest:update"
