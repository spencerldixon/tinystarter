copy_file File.join(File.expand_path("..", __dir__), "files/app/views/shared/_footer.html.erb"), 
  "app/views/shared/_footer.html.erb"

copy_file File.join(File.expand_path("..", __dir__), "files/app/views/shared/_navbar.html.erb"), 
  "app/views/shared/_navbar.html.erb"

copy_file File.join(File.expand_path("..", __dir__), "files/app/views/shared/_sidebar.html.erb"), 
  "app/views/shared/_sidebar.html.erb"

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
    <body class="bg-base-100 text-base-content">
      <%= render "shared/flash" %>

      <div class="drawer lg:drawer-open">
        <input id="my-drawer-2" type="checkbox" class="drawer-toggle" />
        <div class="drawer-content">
          <%= render "shared/navbar" %>

          <main class="p-6">
            <%= yield %>
          </main>

          <label for="my-drawer-2" class="btn btn-primary drawer-button lg:hidden">
            Open drawer
          </label>
        </div>
        <div class="drawer-side sm:border-r border-primary/30">
          <label for="my-drawer-2" aria-label="close sidebar" class="drawer-overlay"></label>
          <%= render "shared/sidebar" %>
        </div>
      </div>
    </body>
  <% end %>
  eos
end

# Create a dashboard page

rails_command "g controller dashboard index"
