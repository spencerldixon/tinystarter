rails_command "g controller static_pages privacy terms_and_conditions"

gsub_file "config/routes.rb", /get \"static_pages\/privacy\"\n/, ""
gsub_file "config/routes.rb", /get \"static_pages\/terms_and_conditions\"/, ""

route "get \"/privacy\", to: \"static_pages#privacy\""
route "get \"/terms_and_conditions\", to: \"static_pages#terms_and_conditions\""

template File.join(File.expand_path("..", __dir__), "files/app/views/static_pages/privacy.html.erb"), 
  "app/views/static_pages/privacy.html.erb", 
  force: true

template File.join(File.expand_path("..", __dir__), "files/app/views/static_pages/terms_and_conditions.html.erb"), 
  "app/views/static_pages/terms_and_conditions.html.erb", 
  force: true

copy_file File.join(File.expand_path("..", __dir__), "files/app/views/layouts/blank.html.erb"), 
  "app/views/layouts/blank.html.erb"

inject_into_file "app/controllers/static_pages_controller.rb", after: "class StaticPagesController < ApplicationController\n" do
  <<-eos
  skip_before_action :authenticate_user!
  layout "blank"
  eos
end
