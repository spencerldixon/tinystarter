# Installs the tailwind typography plugin, used on privacy and terms pages

after_bundle do
  run "bun install @tailwindcss/typography"

  inject_into_file 'tailwind.config.js', after: "plugins: [\n" do
    <<-eos
    require('@tailwindcss/typography'),
    eos
  end
end
