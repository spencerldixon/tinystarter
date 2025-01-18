# 🏁 Minimalist starter

A minimalist starting template for Rails 8+ applications.

No options, just a nice omakase stack and design.

You can edit the list in `tinystarter.rb` to remove any modules you don't want to install

## Use

Clone the repo and reference the `tinystarter.rb` file with the `-m` arguement:

Note you will need tailwind and bun, as tinystarter uses DaisyUI which builds on top of tailwind and cannot be installed via importmaps

```
rails new APP_NAME --css=tailwind --javascript=bun -m tinystarter/tinystarter.rb
```

## TODO

- [ ] FlashController - stimulus
- [ ] Devise layouts (from pm)
- [ ] Devise registration page (controller needed for different layout)
- [ ] Application Layouts (and responsive sidebar)
- [ ] Mission control admin access (ability)
- [ ] Solid queue
- [ ] Mailer config
