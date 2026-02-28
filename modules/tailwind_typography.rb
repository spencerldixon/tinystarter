# description: Installs the Tailwind CSS Typography plugin for prose-styled content pages

after_bundle do
  run "bun install @tailwindcss/typography"

  inject_into_file 'app/assets/stylesheets/application.tailwind.css', after: "@import \"tailwindcss\";\n" do
    <<-eos
    @plugin '@tailwindcss/typography';
    eos
  end
end
