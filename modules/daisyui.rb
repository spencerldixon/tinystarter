after_bundle do
  run "bun install daisyui@latest"

  inject_into_file 'tailwind.config.js', after: "module.exports = {\n" do
    <<-eos
  plugins: [
    require('daisyui')
  ],
    eos
  end

  gsub_file 'app/views/layouts/application.html.erb', /<html>/, "<html data-theme=\"light\">"
end
