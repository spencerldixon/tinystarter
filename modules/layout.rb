# description: Adds navbar, sidebar, footer, and header partials with a dashboard controller

# Copy views

views = %w[
  shared/_footer
  shared/_navbar
  shared/_sidebar
  shared/_header
  layouts/devise
]

views.each do |view|
  copy_file File.join(File.expand_path("..", __dir__), "files/themes/#{FRONTEND}/app/views/#{view}.html.erb"), "app/views/#{view}.html.erb"
end

# Replace main body content in application.html.erb

regex = <<-eos
  <body>
    <%= yield %>
  </body>
eos

gsub_file "app/views/layouts/application.html.erb", regex do
  File.read(File.join(File.expand_path("..", __dir__), "files/themes/#{FRONTEND}/app/views/layouts/application.html.erb"))
end

# Create a dashboard page

rails_command "g controller dashboard index"

copy_file File.join(File.expand_path("..", __dir__), "files/themes/#{FRONTEND}/app/views/dashboard/index.html.erb"), 
  "app/views/dashboard/index.html.erb", force: true
