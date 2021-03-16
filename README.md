# rails-multiUIs-template
**DISCLAIMER**
Repo has been archived due to being unable to lack of compatibility with the newest UI framework versions, being unable to keep up with the changes. I'm planning to return to this project down the line.

A Rails 6 template to quickly generate apps for personal use. The main goal is allow for easy experimentation with different UX/UI frameworks - when running the template just choose a framework from the options available.

Inspired heavily by [Le Wagon's Rails Templates](https://github.com/lewagon/rails-templates). Would not exist without them.

Special thanks also to [Rails Kickoff – Tailwind](https://github.com/justalever/kickoff_tailwind) and [Jumpstart Rails Template](https://github.com/excid3/jumpstart).

### Usage

run `rails new APP-NAME -d=postgresql -T -m https://raw.githubusercontent.com/naokimi/rails-multiUIs-template/master/template.rb`

after rails vanilla installs, pick one of the framework options and press Enter

## Contents

Creating an app using this template gives you an option amongs several UX/UI frameworks, a set of gems to help with you development, and a landing page with a navbar, footer (sticky at bottom with flexbox), banner, and a link to the framework's documentation.

### Framework Options

- [Bootstrap](https://getbootstrap.com/): The most popular HTML, CSS, and JS library in the world
- [Bulma](https://bulma.io/): A pure CSS framework based on Flexbox and built with Sass
- [Foundation](https://get.foundation/): The most advanced responsive front-end framework in the world
- [Tailwind](https://tailwindcss.com/): A utility-first CSS framework for rapidly building custom designs

### Included gems
(Starred items have been added on top of the ones used by Le Wagon's template)

- [annotate\*](https://github.com/ctran/annotate_models): Add a comment summarizing the current schema to the top or bottom of each of your models.
- [autoprefixer-rails](https://github.com/ai/autoprefixer-rails): Parse CSS and add vendor prefixes to CSS rules using values from the Can I Use database.
- [database_cleaner\*](https://github.com/DatabaseCleaner/database_cleaner): Reset ids when emptying database with seeds or rspec
- [dotenv-rails](https://github.com/bkeepers/dotenv): Shim to load environment variables from .env into ENV in development.
- [factory_bot_rails\*](https://github.com/thoughtbot/factory_bot_rails): a fixtures replacement to help you with defining testing objects.
- [faker\*](https://github.com/faker-ruby/faker): Generate fake data for your seeds and tests.
- [font-awesome-sass](https://github.com/FortAwesome/font-awesome-sass): Sass-powered version of the web's most popular icon set and toolkit.
- [friendly_id\*](https://github.com/norman/friendly_id): Create pretty URLs and work with human-friendly strings as if they were numeric ids.
- [mini_magick\*](https://github.com/minimagick/minimagick): An interface between the Ruby programming language and the ImageMagick image processing library
- [pry-byebug](https://github.com/deivid-rodriguez/pry-byebug): Step-by-step debugging and stack navigation capabilities.
- [pry-rails](https://github.com/rweng/pry-rails): Causes `rails console` to open pry.
- [rspec\*](https://github.com/rspec/rspec): Behaviour Driven Development for Ruby.
- [simple_form](https://github.com/heartcombo/simple_form): Rails forms made easy.
- [simplecov\*](https://github.com/simplecov-ruby/simplecov): Atool to help you visualize how much of your app is covered by tests.
- [sitemap_generator\*](https://github.com/kjvarga/sitemap_generator): The easiest way to generate Sitemaps in Ruby.
- [uglifier](https://github.com/mishoo/UglifyJS): Ruby wrapper for UglifyJS JavaScript compressor - a JavaScript parser, minifier, compressor and beautifier toolkit.

## Contributing
See [CONTRIBUTING.md](https://github.com/naokimi/rails-multiUIs-template/blob/master/CONTRIBUTING.md).
