gem "valid_email2"
run "bundle install"

inject_into_file "app/models/user.rb", before: "end" do
  <<-eos
  \n\tvalidates :email, presence: true, 'valid_email_2/email': true
  eos
end
