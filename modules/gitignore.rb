# description: Appends common entries to .gitignore (env files, DS_Store, credentials, DB dumps)
append_to_file '.gitignore' do
  <<-eos
.env
.DS_Store

# Ignore any DB dumps
*.sql
*.sqlite
*.dump

# Ignore credential keys
/config/credentials/production.key
/config/credentials/development.key
/config/credentials/test.key

dump.rdb
.byebug_history
  eos
end
