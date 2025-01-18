# 🏁 tinystarter

A minimalist starting template for Rails 8+ applications.

No options, just a nice omakase stack and design.

You can edit the list in `tinystarter.rb` to remove any modules you don't want to install.

## Use

Clone the repo and reference the `tinystarter.rb` file with the `-m` arguement:

Note you will need tailwind and bun, as tinystarter uses DaisyUI which builds on top of tailwind and cannot be installed via importmaps

```
rails new APP_NAME --css=tailwind --javascript=bun -m tinystarter/tinystarter.rb
cd APP_NAME && rails db:prepare
./bin/dev
```

## TODO

- [ ] Solid queue in procfile
- [ ] Mailer config
- [ ] Kamal deploy GitHub action
- [ ] Exception notification -> slack or telegram
- [ ] Metatags (with sensible defaults)
- [ ] Improve responsiveness of sign up page

