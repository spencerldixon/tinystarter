# description: Adds Docker health checks for the Rails app, Kamal Proxy, and PostgreSQL accessory

dockerfile = "Dockerfile"
deploy_config = "config/deploy.yml"

unless File.read(dockerfile).match?(/^HEALTHCHECK\b/)
  inject_into_file dockerfile, before: /^CMD \["\.\/bin\/thrust"/ do
    <<~DOCKERFILE

      # Report continuous container health to Docker-based monitors such as Beszel.
      HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \\
        CMD curl --fail --silent --show-error http://127.0.0.1/up || exit 1

    DOCKERFILE
  end
end

deploy_yml = File.read(deploy_config)

# Rails ships the proxy example commented out. Make the top-level key active so
# the runtime options apply whether or not SSL and hosts are configured yet.
unless deploy_yml.match?(/^proxy:\s*$/)
  gsub_file deploy_config, /^# proxy:\s*$/, "proxy:"
  deploy_yml = File.read(deploy_config)
end

proxy_block = deploy_yml[/^proxy:\s*\n(?<body>(?:^(?:  |\s*$).*\n)*)/, 0]

if proxy_block && !proxy_block.match?(/^\s+health-cmd:\s*["']?kamal-proxy list/)
  proxy_health_options = <<~YAML.indent(6)
    health-cmd: "kamal-proxy list"
    health-interval: 30s
    health-timeout: 5s
    health-retries: 3
    health-start-period: 10s
  YAML

  updated_proxy_block = if proxy_block.match?(/^    options:\s*$/)
    proxy_block.sub(/^    options:\s*\n/, "\\0#{proxy_health_options}")
  elsif proxy_block.match?(/^  run:\s*$/)
    proxy_block.sub(/^  run:\s*\n/, "\\0    options:\n#{proxy_health_options}")
  else
    proxy_block.sub(/^proxy:\s*\n/) do |proxy_line|
      proxy_line + <<~YAML.indent(2)
        run:
          options:
            health-cmd: "kamal-proxy list"
            health-interval: 30s
            health-timeout: 5s
            health-retries: 3
            health-start-period: 10s
      YAML
    end
  end

  gsub_file deploy_config, proxy_block, updated_proxy_block
end

deploy_yml = File.read(deploy_config)
accessories_block = deploy_yml[/^accessories:\s*\n(?<body>(?:^(?:  |\s*$).*\n?)*)/, 0]
db_block = accessories_block&.[](/^  db:\s*\n(?<body>(?:^(?:    |\s*$).*\n?)*)/, 0)

if db_block
  unless db_block.match?(/^\s+health-cmd:\s*["']?pg_isready\b/)
    postgres_user = db_block[/^\s+POSTGRES_USER:\s*["']?([^\s"']+)/, 1] || app_name
    postgres_database = db_block[/^\s+POSTGRES_DB:\s*["']?([^\s"']+)/, 1] || "#{app_name}_production"
    db_health_options = <<~YAML.indent(6)
      health-cmd: "pg_isready -h 127.0.0.1 -U #{postgres_user} -d #{postgres_database}"
      health-interval: 30s
      health-timeout: 5s
      health-retries: 5
      health-start-period: 20s
    YAML

    updated_db_block = if db_block.match?(/^    options:\s*$/)
      db_block.sub(/^    options:\s*\n/, "\\0#{db_health_options}")
    else
      options = "    options:\n#{db_health_options}"
      with_options = db_block.sub(/^    env:\s*\n/, "#{options}    env:\n")
      with_options == db_block ? db_block.sub(/^  db:\s*\n/, "\\0#{options}") : with_options
    end

    gsub_file deploy_config, db_block, updated_db_block
  end
else
  say "Kamal health checks: skipped PostgreSQL because config/deploy.yml has no active accessories.db block.", :yellow
end
