# description: Adds a GitHub Actions workflow that runs `kamal deploy` after CI passes
files_dir = File.join(File.expand_path("..", __dir__), "files")

copy_file File.join(files_dir, ".github/workflows/deploy.yml"), ".github/workflows/deploy.yml"

# Read the key from ENV so the workflow can pass it as a secret instead of
# shipping a key file. Locally, export it before deploying:
#   export RAILS_MASTER_KEY=$(cat config/credentials/production.key)
if File.exist?(".kamal/secrets")
  gsub_file ".kamal/secrets",
    /RAILS_MASTER_KEY=\$\(cat config\/master\.key\)/,
    "RAILS_MASTER_KEY=$RAILS_MASTER_KEY"
end
