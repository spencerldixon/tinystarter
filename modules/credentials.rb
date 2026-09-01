# description: Generates per-environment encrypted credentials files (development, test, production)
after_bundle do
  remove_file "config/credentials.yml.enc"
  remove_file "config/master.key"

  example_path = File.join(File.expand_path("..", __dir__), "files/config/credentials/example.yml")

  %w[development test production].each do |env|
    # First pass: generate the encrypted file with a fresh secret_key_base
    run "EDITOR=true bin/rails credentials:edit --environment #{env}"
    # Second pass: append the example template (commented-out placeholders)
    run %Q(EDITOR='sh -c "cat #{example_path} >> \\$0"' bin/rails credentials:edit --environment #{env})
  end
end
