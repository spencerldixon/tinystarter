template File.join("../files/app/views/shared/_analytics.html.erb"), "app/views/shared/_analytics.html.erb", force: true

inject_into_file 'app/views/layouts/application.html.erb', :before => "</head>" do
  <<-eos
    <%= render "shared/analytics" %>
  eos
end
