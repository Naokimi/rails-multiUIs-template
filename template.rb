# frozen_string_literal: true

# next step: implement one of the frameworks (bulma?)
# next steo: implement second framework + framework choice option

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

def overwrite_homepage
  run 'rm app/views/pages/home.html.erb'
  file 'app/views/pages/home.html.erb', <<-HTML
    <h1><i class="fas fa-heart"></i>Welcome to our default homepage<i class="fas fa-heart"></i></h1>
  HTML
end

# AFTER BUNDLE
################################################################################

after_bundle do
  generate(:controller, 'pages', 'home', '--skip-routes', '--no-test-framework')
  overwrite_homepage
  generate 'annotate:install'
  generate 'simple_form:install'
  # rails generate simple_form:install --bootstrap
  # rails generate simple_form:install --foundation
  rails_command 'sitemap:install'
  run 'bundle exec spring binstub --all'
  run 'bundle exec wheneverize .'

  rails_command 'db:create db:migrate'

  # Routes
  ########################################
  route "root to: 'pages#home'"

  # Git ignore
  ########################################
  append_file '.gitignore', <<-TXT

  # Ignore .env file containing credentials.
  .env*

  # Ignore Mac and Linux file system files
  *.swp
  .DS_Store
  TXT

  git :init
  git add: '.'
  git commit: %( -m 'Initial commit using personal-projects-template' )
end
