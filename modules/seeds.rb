# description: Creates a default admin user in db/seeds.rb for development
append_to_file 'db/seeds.rb' do
  <<-eos
return if Rails.env.production?

user = User.create(
  email: "test@test.com",
  password: "test1234",
  password_confirmation: "test1234",
  terms_and_conditions: true,
  admin: true
)

user.confirm
  eos
end
