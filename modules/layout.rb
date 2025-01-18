copy_file File.join(File.expand_path("..", __dir__), "files/app/views/shared/_footer.html.erb"), 
  "app/views/shared/_footer.html.erb"

copy_file File.join(File.expand_path("..", __dir__), "files/app/views/layouts/devise.html.erb"), 
  "app/views/layouts/devise.html.erb"

regex = <<-eos
  <body>
    <%= yield %>
  </body>
eos

gsub_file "app/views/layouts/application.html.erb", regex do
  <<-eos
  <% if content_for?(:body) %>
    <%= yield(:body) %>
  <% else %>
    <body>
      <%= yield %>
    </body>
  <% end %>
  eos
end
