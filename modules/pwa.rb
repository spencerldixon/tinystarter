gsub_file "app/views/layouts/application.html.erb", /<%#= tag.link rel: "manifest"/, '<%= tag.link rel: "manifest"'
gsub_file "config/routes.rb", '# get "manifest"', 'get "manifest"'
gsub_file "config/routes.rb", '# get "service-worker"', 'get "service-worker"'
