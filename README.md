# personal-projects-templates
A Rails 6 template to quickly generate apps for personal use. The main goal is allow for easy experimentation with different UX/UI frameworks - when running the template just choose a framework from the options available.

Inspired heavily by [Le Wagon's Rails Templates](https://github.com/lewagon/rails-templates). Would not exist without them.

Special thanks also to [Rails Kickoff – Tailwind](https://github.com/justalever/kickoff_tailwind) and [Jumpstart Rails Template](https://github.com/excid3/jumpstart).

### Usage

run `rails new APP-NAME -d=postgresql -T -m personal-projects-templates/template.rb`
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
- [dotenv-rails](https://github.com/bkeepers/dotenv): Shim to load environment variables from .env into ENV in development.
- [faker\*](https://github.com/faker-ruby/faker): Generate fake data for your seeds and tests.
- [font-awesome-sass](https://github.com/FortAwesome/font-awesome-sass): Sass-powered version of the web's most popular icon set and toolkit.
- [friendly_id\*](https://github.com/norman/friendly_id): Create pretty URLs and work with human-friendly strings as if they were numeric ids.
- [mini_magick\*](https://github.com/minimagick/minimagick): An interface between the Ruby programming language and the ImageMagick image processing library
- [pg](https://github.com/ged/ruby-pg): The Ruby interface to the PostgreSQL RDBMS.
- [pry-byebug](https://github.com/deivid-rodriguez/pry-byebug): Step-by-step debugging and stack navigation capabilities.
- [pry-rails](https://github.com/rweng/pry-rails): Causes `rails console` to open pry.
- [rspec\*](https://github.com/rspec/rspec): Behaviour Driven Development for Ruby.
- [sassc-rails](https://github.com/sass/sassc-rails): Integrates the C implementation of Sass into the asset pipeline to make compilation faster.
- [simple_form](https://github.com/heartcombo/simple_form): Rails forms made easy.
- [sitemap_generator\*](https://github.com/kjvarga/sitemap_generator): The easiest way to generate Sitemaps in Ruby.
- [spring](https://github.com/rails/spring): Rails application preloader. It speeds up development by keeping your application running in the background so you don't need to boot it every time you run a test, rake task or migration.
- [uglifier](https://github.com/mishoo/UglifyJS): Ruby wrapper for UglifyJS JavaScript compressor - a JavaScript parser, minifier, compressor and beautifier toolkit.
- [whenever\*](https://github.com/javan/whenever): Provides a clear syntax for writing and deploying cron jobs.

## Contributing
See [CONTRIBUTING.md](https://github.com/naokimi/personal-project-templates/blob/master/CONTRIBUTING.md).
