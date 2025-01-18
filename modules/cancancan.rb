gem "cancancan"
run "bundle install"
rails_command("g cancan:ability")

inject_into_file "app/controllers/application_controller.rb", before: /protected/, force: true do
  <<-eos
  \nrescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end\n
  eos
end
