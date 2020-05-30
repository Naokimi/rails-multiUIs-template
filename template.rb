# frozen_string_literal: true

# GEMS
################################################################################

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

# LAYOUT
################################################################################

remove_file 'app/assets/stylesheets/application.css'
file 'app/assets/stylesheets/application.css.scss', <<-SCSS
  @import "font-awesome-sprockets";
  @import "font-awesome";
SCSS

run 'rm app/views/layouts/application.html.erb'
file 'app/views/layouts/application.html.erb', <<-HTML
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <title>TODO</title>
      <%= csrf_meta_tags %>
      <%= action_cable_meta_tag %>
      <%= stylesheet_link_tag 'application', media: 'all' %>
      <%#= stylesheet_pack_tag 'application', media: 'all' %> <!-- Uncomment if you import CSS in app/javascript/packs/application.js -->
    </head>
    <body>
      <%= yield %>
      <%= javascript_pack_tag 'application' %>
    </body>
  </html>
HTML

# AFTER BUNDLE
################################################################################

after_bundle do
  generate 'annotate:install'
  generate 'simple_form:install'
  # rails generate simple_form:install --bootstrap
  # rails generate simple_form:install --foundation
  rails_command 'sitemap:install'
  run 'bundle exec spring binstub --all'

  rails_command 'db:create db:migrate'

  git :init
  git add: '.'
  git commit: %( -m 'Initial commit using personal-projects-template' )
end
