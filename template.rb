# frozen_string_literal: true

# add navbar and footer to bulma
# next step: implement second framework + framework choice option
# next step: move methods into support folder/file

# GEMS
################################################################################

gem 'autoprefixer-rails'
gem 'bulma-rails', '~> 0.8.2'
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
  @import "bulma";
SCSS

run 'rm app/views/layouts/application.html.erb'
file 'app/views/layouts/application.html.erb', <<-HTML
  <!DOCTYPE html>
  <html>
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <title>Personal Projects Template</title>
      <%= csrf_meta_tags %>
      <%= action_cable_meta_tag %>
      <%= stylesheet_link_tag 'application', media: 'all' %>
    </head>
    <body>
      <nav class="navbar" role="navigation" aria-label="main navigation">
        <div class="navbar-brand">
          <a class="navbar-item" href="https://bulma.io">
            <img src="https://bulma.io/images/bulma-logo.png" width="112" height="28">
          </a>

          <a role="button" class="navbar-burger burger" aria-label="menu" aria-expanded="false" data-target="navbarBasicExample">
            <span aria-hidden="true"></span>
            <span aria-hidden="true"></span>
            <span aria-hidden="true"></span>
          </a>
        </div>

        <div id="navbarBasicExample" class="navbar-menu">
          <div class="navbar-start">
            <a class="navbar-item">
              Home
            </a>

            <a class="navbar-item">
              Documentation
            </a>

            <div class="navbar-item has-dropdown is-hoverable">
              <a class="navbar-link">
                More
              </a>

              <div class="navbar-dropdown">
                <a class="navbar-item">
                  About
                </a>
                <a class="navbar-item">
                  Jobs
                </a>
                <a class="navbar-item">
                  Contact
                </a>
                <hr class="navbar-divider">
                <a class="navbar-item">
                  Report an issue
                </a>
              </div>
            </div>
          </div>

          <div class="navbar-end">
            <div class="navbar-item">
              <div class="buttons">
                <a class="button is-primary">
                  <strong>Sign up</strong>
                </a>
                <a class="button is-light">
                  Log in
                </a>
              </div>
            </div>
          </div>
        </div>
      </nav>
      <%= yield %>
      <footer class="footer">
        <div class="content has-text-centered">
          <p>
            <strong>Bulma</strong> by <a href="https://jgthms.com">Jeremy Thomas</a>. The source code is licensed
            <a href="http://opensource.org/licenses/mit-license.php">MIT</a>.
          </p>
          <p>
            Rails template made by <a href="https://github.com/Naokimi"><i class="fab fa-github"></i> Naokimi</a>
          </p>
        </div>
      </footer>
      <%= javascript_pack_tag 'application' %>
    </body>
  </html>
HTML

def overwrite_homepage
  run 'rm app/views/pages/home.html.erb'
  file 'app/views/pages/home.html.erb', <<-HTML
    <section class="hero is-primary">
      <div class="hero-body">
        <div class="container">
          <h1 class="title">
            <i class="fas fa-heart"></i> Bulma Framework <i class="fas fa-heart"></i>
          </h1>
          <h2 class="subtitle">
            A framework without any JavaScript. Discover how to <strong>customize</strong> it!
          </h2>
          <p>
            <a class="button is-light" href="https://bulma.io/documentation/overview/start/">Documentation</a>
          </p>
        </div>
      </div>
    </section>
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
