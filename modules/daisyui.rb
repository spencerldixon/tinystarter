after_bundle do
  run "bun install daisyui@latest"

  append_to_file 'app/assets/stylesheets/application.tailwind.css' do
    <<-eos
@plugin "daisyui";
    eos
  end

  gsub_file 'app/views/layouts/application.html.erb', /<html>/, "<html data-theme=\"light\">"
end
