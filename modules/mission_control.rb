gem "mission_control-jobs"

inject_into_file 'config/application.rb', before: /^\s\send\nend/ do
  <<-eos

    config.mission_control.jobs.http_basic_auth_enabled = false
  eos
end

route <<-eos
  authenticate :user, ->(user) { user.admin? } do
    mount MissionControl::Jobs::Engine, at: \"/jobs\"
  end
eos

# Add to development environment

inject_into_file "config/environments/development.rb", after: "Rails.application.configure do" do
  <<-eos
  \nconfig.active_job.queue_adapter = :solid_queue
  config.solid_queue.connects_to = { database: { writing: :queue } }
  eos
end

from = <<-eos
development:
  <<: *default
  database: storage/development.sqlite3
eos

to = <<-eos
development:
  primary:
    <<: *default
    database: storage/development.sqlite3
  queue:
    <<: *default
    database: storage/development_queue.sqlite3
    migrations_paths: db/queue_migrate
eos

gsub_file "config/database.yml", from, to 
