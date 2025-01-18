after_bundle do
  run "bun install @fortawesome/fontawesome-free"

  append_to_file 'app/javascript/application.js' do
    <<-eos
import "@fortawesome/fontawesome-free/js/all"
    eos
  end
end
