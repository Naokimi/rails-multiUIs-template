# frozen_string_literal: true

gem 'autoprefixer-rails'
gem 'font-awesome-sass', '~> 5.12.0'
gem 'friendly_id', '~> 5.3'
gem 'mini_magick'
gem 'pg'
gem 'sassc-rails'
gem 'simple_form'
gem 'sitemap_generator'
gem 'uglifier'
gem 'whenever', require: false

gem_group :development, :test do
  gem 'annotate'
  gem 'dotenv-rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec'
  gem 'spring'
end

after_bundle do
  generate('annotate:install')
  generate('simple_form:install')
  # rails generate simple_form:install --bootstrap
  # rails generate simple_form:install --foundation
  rails_command('sitemap:install')
  run('bundle exec spring binstub --all')

  rails_command('db:create')
  rails_command('db:migrate')

  git(:init)
  git(add: '.')
  git(commit: %( -m 'Initial commit using personal-projects-template' ))
end
