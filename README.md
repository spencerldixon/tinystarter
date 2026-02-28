# 🏁 tinystarter

A dynamic starting template for Rails applications.

## Use

Clone the repo and reference the `tinystarter.rb` file with the `-m` argument:

Note you will need tailwind and bun, as tinystarter uses frontends which builds on top of tailwind and cannot be installed via importmaps

```
rails new APP_NAME --css=tailwind --javascript=bun -m /tinystarter/tinystarter.rb
cd APP_NAME && rails db:prepare
./bin/dev
```

Tinystarter will run through an interactive prompt to choose your UI and modules to install

### After install

Here's a check list of things to do after creating an app with tinystarter:

- Find and replace `tinyapp` with the name of your app. This is used in some headers
- Drop your analytics code in `views/shared/_analytics.html.erb`
- Change `views/shared/_footer.html.erb` to your url of choice
- Drop a privacy policy and terms and conditions in `views/static_pages/privacy.html.erb` and `views/static_pages/terms_and_conditions.html.erb`

## Modules List

| Module | Description |
|---|---|
| `basecoat` | Installs Basecoat CSS component library built on top of Tailwind |
| `daisyui` | Installs DaisyUI component library and sets the default light theme |
| `analytics` | Adds an analytics partial injected into the application layout head |
| `active_link_to` | Adds the active_link_to helper for marking active navigation links |
| `cancancan` | Adds role-based authorisation via CanCanCan with an Ability class |
| `devise` | Adds full authentication via Devise with lockable, confirmable, and trackable modules |
| `flash` | Adds flash message partial, helper, and auto-dismissing Stimulus controller |
| `font_awesome` | Installs Font Awesome free icon set via Bun |
| `gitignore` | Appends common entries to .gitignore (env files, DS_Store, credentials, DB dumps) |
| `layout` | Adds navbar, sidebar, footer, and header partials with a dashboard controller |
| `legal_pages` | Generates privacy policy and terms & conditions pages with a blank layout |
| `license` | Adds the O'Saasy source-available licence as LICENSE.md |
| `mission_control` | Mounts Mission Control for job monitoring at /jobs, restricted to admin users |
| `onboarding_modal` | Adds a post-signup onboarding modal with confetti animation via Stimulus |
| `pwa` | Enables the Rails PWA manifest and service worker routes |
| `remove_trailing_slashes` | Adds Rack middleware to 301 redirect URLs with trailing slashes |
| `rspec` | Installs RSpec and FactoryBot for testing, with optional Devise test helpers |
| `seeds` | Creates a default admin user in db/seeds.rb for development |
| `tailwind_typography` | Installs the Tailwind CSS Typography plugin for prose-styled content pages |
| `valid_email` | Validates email format on the User model using the valid_email2 gem |

## TODO

- [x] Rspec / factorybot config
- [ ] devise allow unconfirmed access
- [ ] modal / onboarding
- [ ] Basic tests
- [ ] Mailer config
- [ ] Exception notification -> slack or telegram
- [ ] Metatags (with sensible defaults)

## Customising / Contributing

### Adding your own Recipes

You can create custom sets of modules to install. Put a ruby file with an array of modules in `/recipes`. It will be picked up by the installer as an option during app creation.

### Adding your own Modules

Modules are a ruby file stored in `/modules` that use the thor templating language. They should start with a comment that starts with `# description: Description of your module` as the first line. This will be displayed during install.

Don't forget to add your module to the `all_modules` list in `tinystarter.rb`
