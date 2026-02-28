# description: Installs RSpec and FactoryBot for testing, with optional Devise test helpers
gem_group :development, :test do
  gem "rspec-rails"
  gem "factory_bot_rails"
end

run "bundle install"
rails_command "generate rspec:install"

inject_into_file "spec/rails_helper.rb", after: "RSpec.configure do |config|\n" do
  helpers = "  config.include FactoryBot::Syntax::Methods\n"

  if File.read("Gemfile") =~ /gem ['"]devise['"]/
    helpers += "  config.include Devise::Test::IntegrationHelpers, type: :request\n"
    helpers += "  config.include Devise::Test::ControllerHelpers, type: :controller\n"
  end

  helpers + "\n"
end
