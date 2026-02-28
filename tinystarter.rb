# Install tty-prompt for user input
begin
  require 'tty-prompt'
rescue LoadError
  system("gem install tty-prompt --quiet")
  require 'tty-prompt'
end

# Set up a new prompt
prompt = TTY::Prompt.new

# Select UI (informs which file templates to use)
FRONTEND = prompt.select("Which frontend would you like?") do |menu|
  menu.choice "Basecoat", "basecoat"
  menu.choice "DaisyUI",  "daisyui"
end

# Select install type
install_type = prompt.select("How would you like to configure your install?") do |menu|
  menu.choice "Use a recipe",     "recipe"
  menu.choice "Customise my own", "custom"
end

# Parse module description from file first line comment
def module_description(path)
  File.foreach(path) do |line|
    return $1.strip if line =~ /^# description: (.+)/i
    break unless line.start_with?("#")
  end
  nil
end

# List of all modules to select from
ALL_MODULES = %w[
  gitignore
  remove_trailing_slashes
  seeds
  font_awesome
  active_link_to
  tailwind_typography
  flash
  legal_pages
  license
  devise
  cancancan
  valid_email
  onboarding_modal
  mission_control
  analytics
  pwa
  layout
  rspec
]

# Dynamically configure modules
modules = [FRONTEND]

if install_type == "recipe"
  recipe_files = Dir[File.join(__dir__, "recipes", "*.rb")].sort

  selected = prompt.select("Which recipe?") do |menu|
    recipe_files.each do |path|
      name = File.basename(path, ".rb")
      menu.choice name.gsub("_", " ").capitalize, path
    end
  end

  modules += instance_eval(File.read(selected), selected)
else
  selected = prompt.multi_select("Choose modules to install:", echo: false) do |menu|
    ALL_MODULES.each do |mod|
      path = File.join(__dir__, "modules", "#{mod}.rb")
      desc = module_description(path)
      label = mod.gsub("_", " ").capitalize
      label += " — #{desc}" if desc
      menu.choice label, mod
    end
  end

  modules += selected
end

# Iterate and install modules
modules.each do |module_name|
  file_path = File.join(__dir__, "modules", "#{module_name}.rb")
  instance_eval(File.read(file_path), file_path)
end
