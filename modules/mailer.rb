# description: Configures ActionMailer with SMTP settings + default_from sourced from per-env credentials
copy_file File.join(File.expand_path("..", __dir__), "files/app/mailers/application_mailer.rb"),
  "app/mailers/application_mailer.rb",
  force: true

inject_into_file "config/application.rb", before: /^\s\send\nend/ do
  <<-RUBY
\n
    mailer_creds = Rails.application.credentials.mailer || {}
    smtp_creds   = Rails.application.credentials.smtp || {}

    config.action_mailer.default_url_options = {
      host: mailer_creds[:default_url_host] || "localhost",
      port: mailer_creds[:default_url_port] || 3000
    }

    if smtp_creds[:address].present?
      config.action_mailer.delivery_method = :smtp
      config.action_mailer.perform_deliveries = true
      config.action_mailer.raise_delivery_errors = true
      config.action_mailer.smtp_settings = {
        address:              smtp_creds[:address],
        port:                 smtp_creds[:port] || 587,
        domain:               smtp_creds[:domain],
        user_name:            smtp_creds[:user_name],
        password:             smtp_creds[:password],
        authentication:       :plain,
        enable_starttls_auto: true
      }
    end
  RUBY
end
