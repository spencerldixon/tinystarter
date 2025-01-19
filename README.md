# 🏁 tinystarter

A minimalist starting template for Rails 8+ applications.

No options, just a nice omakase stack and design.

You can edit the list in `tinystarter.rb` to remove any modules you don't want to install.

## Use

Clone the repo and reference the `tinystarter.rb` file with the `-m` argument:

Note you will need tailwind and bun, as tinystarter uses DaisyUI which builds on top of tailwind and cannot be installed via importmaps

```
rails new APP_NAME --css=tailwind --javascript=bun -m /tinystarter/tinystarter.rb
cd APP_NAME && rails db:prepare
./bin/dev
```

## After

Here's a check list of things to do after creating an app with tinystarter:

- Find and replace `tinyapp` with the name of your app. This is used in some headers
- Drop your analytics code in `views/shared/_analytics.html.erb`
- Change `views/shared/_footer.html.erb` to your url of choice
- Drop a privacy policy and terms and conditions in `views/static_pages/privacy.html.erb` and `views/static_pages/terms_and_conditions.html.erb`

## TODO

- [ ] modal / onboarding
- [ ] page header partial
- [ ] tests
- [ ] Mailer config
- [ ] Kamal deploy GitHub action
- [ ] Exception notification -> slack or telegram
- [ ] Metatags (with sensible defaults)

