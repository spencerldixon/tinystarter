# Load modules in a specific order

modules = %w(
  daisyui
  font_awesome
  gitignore
  remove_trailing_slashes
  robots
  seeds
  home_page
  legal_pages
  mission_control
  devise
  cancancan
  layout
  pwa
  valid_email
)

# Execute each module

modules.each do |module_name|
  file_path = File.join(__dir__, "modules", "#{module_name}.rb")

  instance_eval(File.read(file_path), file_path)
end
