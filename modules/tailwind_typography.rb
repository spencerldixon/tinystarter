# Installs the tailwind typography plugin, used on privacy and terms pages

after_bundle do
  run "bun install @tailwindcss/typography"

  inject_into_file 'app/assets/stylesheets/application.tailwind.css', after: "@import \"tailwindcss\";\n" do
    <<-eos
    @plugin '@tailwindcss/typography';
    eos
  end
end
