# 🏁 tinystarter

A dynamic starting template generator for Rails apps

## Use

Clone the repo and reference the `tinystarter.rb` file with the `-m` argument:

Note you will need tailwind and bun, as tinystarter uses frontends which builds on top of tailwind and cannot be installed via importmaps

```
rails new APP_NAME --database=postgresql --css=tailwind --javascript=bun -m ~/Rails/tinystarter/tinystarter.rb
```

Tinystarter will run through an interactive prompt to choose which modules to install in your project

## Modules List

| Module | Description |
|---|---|
| `basecoat` | Installs Basecoat CSS component library built on top of Tailwind |
| `daisyui` | Installs DaisyUI component library and sets the default light theme |
| `analytics` | Adds an analytics partial injected into the application layout head |
| `active_link_to` | Adds the active_link_to helper for marking active navigation links |
| `cancancan` | Adds role-based authorisation via CanCanCan with an Ability class |
| `credentials` | Generates per-environment encrypted credentials files (development, test, production) |
| `devise` | Adds full authentication via Devise with lockable, confirmable, and trackable modules |
| `devise_google_omniauth` | Adds Google OAuth2 sign-in via Devise omniauthable (requires devise module) |
| `flash` | Adds flash message partial, helper, and auto-dismissing Stimulus controller |
| `font_awesome` | Installs Font Awesome free icon set via Bun |
| `gitignore` | Appends common entries to .gitignore (env files, DS_Store, credentials, DB dumps) |
| `kamal_healthchecks` | Adds Docker health checks for the Rails app, Kamal Proxy, and PostgreSQL accessory |
| `kamal_deploy` | Adds a GitHub Actions workflow that runs `kamal deploy` after CI passes |
| `layout` | Adds navbar, sidebar, footer, and header partials with a dashboard controller |
| `legal_pages` | Generates privacy policy and terms & conditions pages with a blank layout |
| `mailer` | Configures ActionMailer with SMTP settings + default_from sourced from per-env credentials |
| `mission_control` | Mounts Mission Control for job monitoring at /jobs, restricted to admin users |
| `solid_queue_postgres` | Configures Solid Queue to use a single PostgreSQL database with an inline migration |
| `onboarding_modal` | Adds a post-signup onboarding modal with confetti animation via Stimulus |
| `pwa` | Enables the Rails PWA manifest and service worker routes |
| `remove_trailing_slashes` | Adds Rack middleware to 301 redirect URLs with trailing slashes |
| `rspec` | Installs RSpec and FactoryBot for testing, with optional Devise test helpers |
| `seeds` | Creates a default admin user in db/seeds.rb for development |
| `tailwind_typography` | Installs the Tailwind CSS Typography plugin for prose-styled content pages |
| `telegram_exceptions` | Forwards unhandled exceptions to a Telegram chat for real-time error alerts |
| `telegram_notifications` | Adds a TelegramNotifier service for sending custom notifications to a Telegram chat |
| `valid_email` | Validates email format on the User model using the valid_email2 gem |

### Kamal health checks

Select the `kamal_healthchecks` module to add Docker-native health checks for:

- the Rails container, using the standard Rails `/up` endpoint;
- Kamal Proxy, using `kamal-proxy list`; and
- an active PostgreSQL `accessories.db` entry, using `pg_isready` with its configured `POSTGRES_USER` and `POSTGRES_DB` values.

Define the PostgreSQL accessory before applying this module. If `config/deploy.yml` does not contain an active `accessories.db` block, the generator skips the database health check and prints a warning instead of creating an incomplete accessory without a deployment host.

## Post install checklist

Here's a check list of things to do after creating an app with tinystarter:

- Find and replace `tinyapp` with the name of your app. This is used in some headers
- Drop your analytics code in `views/shared/_analytics.html.erb`
- Change `views/shared/_footer.html.erb` to your url of choice
- Drop a privacy policy and terms and conditions in `views/static_pages/privacy.html.erb` and `views/static_pages/terms_and_conditions.html.erb`

## Recipes

Recipes are preset bundles of modules for common app types. Pick **"Use a recipe"** from the interactive prompt and you'll see every file in `/recipes` listed as a choice.

Two ship out of the box:

- `saas` — full software as a service app stack: devise, cancancan, job queue, mailer, mission control, layout, legal pages, analytics, etc.
- `website` — minimal frontend marketing site: gitignore, typography, analytics, flash.

### Writing a recipe

A recipe is a `.rb` file whose last expression is an array of module names (matching files in `/modules`, without the `.rb`). The frontend you picked at the prompt is prepended automatically, do not list `basecoat` or `daisyui`.

Create `recipes/blog.rb`:

```ruby
%w[
  gitignore
  credentials
  tailwind_typography
  legal_pages
  flash
]
```

Drop the file in `/recipes` and it shows up the next time you run the installer. The display name is the filename with underscores replaced by spaces (`my_recipe.rb` → `My recipe`).

## Customising / Contributing

### Adding your own modules

Modules are plain ruby files that automate the install of something in your rails app using the thor templating language.

Modules live in `/modules` and must begin with a comment to describe what the module does in the following format:

```
# description: Adds authentication
```

This description is used in the interactive prompt.

Add your module to the `ALL_MODULES` array in `tinystarter.rb` to add it to the options for installation.
