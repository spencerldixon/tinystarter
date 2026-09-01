# description: Creates an empty shared/analytics partial and adds it into the main application layout head
create_file "app/views/shared/_analytics.html.erb"

inject_into_file 'app/views/layouts/application.html.erb', :before => "</head>" do
  <<-eos
    <%= render "shared/analytics" %>
  eos
end
