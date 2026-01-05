after_bundle do
  run "bun install basecoat-css@latest"

  append_to_file 'app/assets/stylesheets/application.tailwind.css' do
    <<-eos
@import "basecoat-css";
    eos
  end
end
