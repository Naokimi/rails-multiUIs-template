# frozen_string_literal: true

def gems
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
end

def overwrite_layout
  application_css
  application_html
  navbar
  footer
end

def application_html
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
        <%= render 'pages/navbar' %>
        <%= yield %>
        <%= render 'pages/footer' %>
        <%= javascript_pack_tag 'application' %>
      </body>
    </html>
  HTML
end

def homepage_controller
  generate(:controller, 'pages', 'home', '--skip-routes', '--no-test-framework')
  route "root to: 'pages#home'"
end

def generate_installs_and_migrate
  generate 'annotate:install'
  rails_command 'sitemap:install'
  run 'bundle exec spring binstub --all'
  run 'bundle exec wheneverize .'
  rails_command 'db:create db:migrate'
end

def git_ignore
  append_file '.gitignore', <<-TXT

  # Ignore .env file containing credentials.
  .env*

  # Ignore Mac and Linux file system files
  *.swp
  .DS_Store
  TXT
end

def commit_and_push
  git :init
  git add: '.'
  git commit: %( -m 'Initial commit using personal-projects-template' )
  # run 'hub create'
  # git push: 'origin master'
end

def simple_form_install
  generate 'simple_form:install'
  # rails generate simple_form:install --bootstrap
  # rails generate simple_form:install --foundation
end
