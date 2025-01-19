# Load modules in a specific order

modules = %w(
  daisyui
  font_awesome
  gitignore
  remove_trailing_slashes
  robots
  seeds
  legal_pages
  mission_control
  devise
  cancancan
  flash
  layout
  pwa
  valid_email
  active_link_to
  tailwind_typography
  onboarding_modal
)

# Execute each module

modules.each do |module_name|
  file_path = File.join(__dir__, "modules", "#{module_name}.rb")

  instance_eval(File.read(file_path), file_path)
end
