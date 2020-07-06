
def gems
  gem 'autoprefixer-rails'
  gem 'faker'
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

def application_css
  remove_file 'app/assets/stylesheets/application.css'
  file 'app/assets/stylesheets/application.scss', <<-SCSS
@import "font-awesome-sprockets";
@import "font-awesome";
  SCSS
end

def homepage_controller
  generate(:controller, 'pages', 'home', '--skip-routes')
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
end

def bootstrap_install
  run 'yarn add popper.js jquery bootstrap'
end

def bootstrap_simple_form_install
  generate('simple_form:install', '--bootstrap')
end

def bootstrap_layout
  bootstrap_assets
  bootstrap_application_js
  bootstrap_application_html
  bootstrap_navbar
  bootstrap_footer
end

def bootstrap_assets
  import_lewagon_assets
  remove_lewagon_design
end

def import_lewagon_assets
  run 'rm -rf app/assets/stylesheets'
  run 'rm -rf vendor'
  run 'curl -L https://github.com/lewagon/stylesheets/archive/master.zip > stylesheets.zip'
  run 'unzip stylesheets.zip -d app/assets && rm stylesheets.zip && mv app/assets/rails-stylesheets-master app/assets/stylesheets'
end

def remove_lewagon_design
  run 'rm app/assets/stylesheets/components/_alert.scss'
  run 'rm app/assets/stylesheets/components/_avatar.scss'
  run 'rm app/assets/stylesheets/components/_navbar.scss'
  run 'rm app/assets/stylesheets/config/_bootstrap_variables.scss'
  file 'app/assets/stylesheets/components/_alert.scss'
  file 'app/assets/stylesheets/components/_avatar.scss'
  file 'app/assets/stylesheets/components/_navbar.scss'
  file 'app/assets/stylesheets/config/_bootstrap_variables.scss', <<-CODE
// This is where you override default Bootstrap variables
// 1. All Bootstrap variables are here => https://github.com/twbs/bootstrap/blob/master/scss/_variables.scss
// 2. These variables are defined with default value (see https://robots.thoughtbot.com/sass-default)
// 3. You can override them below!

// General style
$font-family-sans-serif:  $body-font;
$headings-font-family:    $headers-font;
$body-bg:                 $light-gray;
$font-size-base: 1rem;

// Colors
$body-color: $gray;
$primary:    $blue;
$success:    $green;
$info:       $yellow;
$danger:     $red;
$warning:    $orange;

// Override other variables below!

  CODE
end

def bootstrap_application_js
  run 'rm app/javascript/packs/application.js'
  file 'app/javascript/packs/application.js', <<-JS
import "bootstrap";
  JS

  inject_into_file 'config/webpack/environment.js', before: 'module.exports' do
  <<-JS
const webpack = require('webpack')
// Preventing Babel from transpiling NodeModules packages
environment.loaders.delete('nodeModules');
// Bootstrap 4 has a dependency over jQuery & Popper.js:
environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
)
JS
  end
end

def bootstrap_application_html
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
    <div class="d-flex flex-column justify-content-between min-vh-100">
    <%= render 'pages/navbar' %>
      <div class="container">
        <%= yield %>
      </div>
      <%= render 'pages/footer' %>
    </div>
    <%= javascript_pack_tag 'application' %>
  </body>
</html>
  HTML
end

def bootstrap_navbar
  file 'app/views/pages/_navbar.html.erb', <<-HTML
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="https://getbootstrap.com/">
    <img src="https://getbootstrap.com/docs/4.5/assets/brand/bootstrap-solid.svg" width="30" height="30" class="d-inline-block align-top" alt="" loading="lazy">
    Bootstrap
  </a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">Link</a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          Dropdown
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Something else here</a>
        </div>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
      </li>
    </ul>
    <form class="form-inline my-2 my-lg-0">
      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
  </div>
</nav>
  HTML
end

def bootstrap_footer
  file 'app/views/pages/_footer.html.erb', <<-HTML
<footer class="footer mt-auto py-3">
  <div class="container">
    <p>
      <strong>Bootstrap</strong> by the <a href="https://getbootstrap.com/docs/4.5/about/team/">Bootstrap team</a>. Code licensed
      <a href="https://github.com/twbs/bootstrap/blob/master/LICENSE">MIT</a>, docs <a href="https://creativecommons.org/licenses/by/3.0/">CC BY 3.0</a>.
    </p>
    <p>
      Rails template made by <a href="https://github.com/Naokimi"><i class="fab fa-github"></i> Naokimi</a>
    </p>
  </div>
</footer>
  HTML
end

def bootstrap_homepage
  run 'rm app/views/pages/home.html.erb'
  file 'app/views/pages/home.html.erb', <<-HTML
<div class="container my-5">
  <h1>
    <i class="fas fa-heart"></i> Bootstrap Framework <i class="fas fa-heart"></i>
  </h1>
  <h2>
    Build fast, responsive sites. Discover how to <strong>customize</strong> it!
  </h2>
  <p>
    <a class="btn btn-primary" href="https://getbootstrap.com/docs/4.5/getting-started/introduction/">Documentation</a>
  </p>
</div>
  HTML
end

def bootstrap_framework
  gems

  after_bundle do
    bootstrap_install
    bootstrap_layout
    homepage_controller
    bootstrap_homepage
    bootstrap_simple_form_install
    generate_installs_and_migrate
    git_ignore
    commit_and_push
  end
end

def bulma_gems
  gem 'bulma-rails', '~> 0.8.2'
end

def bulma_layout
  bulma_application_css
  application_html
  bulma_navbar
  bulma_footer
end

def bulma_application_css
  remove_file 'app/assets/stylesheets/application.css'
  file 'app/assets/stylesheets/application.scss', <<-SCSS
@import "font-awesome-sprockets";
@import "font-awesome";
@import "bulma";
  SCSS
end

def bulma_navbar
  file 'app/views/pages/_navbar.html.erb', <<-HTML
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
  HTML
end

def bulma_footer
  file 'app/views/pages/_footer.html.erb', <<-HTML
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
  HTML
end

def bulma_homepage
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

def bulma_framework
  gems
  bulma_gems
  bulma_layout

  after_bundle do
    homepage_controller
    bulma_homepage
    simple_form_install
    generate_installs_and_migrate
    git_ignore
    commit_and_push
  end
end

def install_foundation
  run 'yarn add jquery foundation-sites motion-ui'
end

def foundation_config_files
  remove_file 'config/webpack/environment.js'
  file 'config/webpack/environment.js', <<-CODE
const { environment } = require('@rails/webpacker')
const webpack = require("webpack")
environment.plugins.append("Provide", new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery'
}))

module.exports = environment
  CODE
end

def foundation_simple_form_install
  generate('simple_form:install', '--foundation')
end

def foundation_layout
  foundation_application_css
  foundation_application_html
  foundation_navbar
  foundation_footer
end

def foundation_application_css
  file 'app/javascript/src/application.scss', <<-SCSS
@import '~foundation-sites/dist/css/foundation';
@import '~motion-ui/motion-ui';
  SCSS
  inject_into_file 'app/javascript/packs/application.js', <<-CODE
import "foundation-sites"
require("src/application")

$(document).on('turbolinks:load', function() {
  $(document).foundation()
});
  CODE
end

def foundation_application_html
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
    <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= stylesheet_pack_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
  </head>
  <body class="flex flex-col h-screen font-sans" >
    <%= render 'pages/navbar' %>
    <%= yield %>
    <%= render 'pages/footer' %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
  </body>
</html>
  HTML
end

def foundation_navbar
  file 'app/views/pages/_navbar.html.erb', <<-HTML
<div class="title-bar" data-responsive-toggle="responsive-menu" data-hide-for="medium">
  <button class="menu-icon" type="button" data-toggle="responsive-menu"></button>
  <div class="title-bar-title">Menu</div>
</div>

<div class="top-bar" id="responsive-menu">
  <div class="top-bar-left">
    <ul class="dropdown menu" data-dropdown-menu>
      <li class="menu-text">Site Title</li>
      <li class="has-submenu">
        <a href="#0">One</a>
        <ul class="submenu menu vertical" data-submenu>
          <li><a href="#0">One</a></li>
          <li><a href="#0">Two</a></li>
          <li><a href="#0">Three</a></li>
        </ul>
      </li>
      <li><a href="#0">Two</a></li>
      <li><a href="#0">Three</a></li>
    </ul>
  </div>
  <div class="top-bar-right">
    <ul class="menu">
      <li><input type="search" placeholder="Search"></li>
      <li><button type="button" class="button">Search</button></li>
    </ul>
  </div>
</div>
  HTML
end

def foundation_footer
  file 'app/views/pages/_footer.html.erb', <<-HTML
<footer>
  <p>
    Rails template made by <a href="https://github.com/Naokimi"><i class="fab fa-github"></i> Naokimi</a>
  </p>
</footer>
  HTML
end

def foundation_homepage
  run 'rm app/views/pages/home.html.erb'
  file 'app/views/pages/home.html.erb', <<-HTML
<div class="container">
  <h1>
    <i class="fas fa-heart"></i> Foundation Framework <i class="fas fa-heart"></i>
  </h1>
  <h2>
    Responsive design gets a whole lot faster. Discover how to <strong>customize</strong> it!
  </h2>
  <p>
    <a class="button primary" href="https://get.foundation/sites/docs/index.html">Documentation</a>
  </p>
</div>
  HTML
end

def foundation_framework
  gems
  install_foundation
  foundation_layout

  after_bundle do
    foundation_config_files
    homepage_controller
    foundation_homepage
    foundation_simple_form_install
    generate_installs_and_migrate
    git_ignore
    commit_and_push
  end
end

def install_tailwind
  run 'yarn add tailwindcss'
end

def tailwind_config_files
  remove_file 'postcss.config.js'
  file 'postcss.config.js', <<-JS
let environment = {
  plugins: [
    require('tailwindcss')('./app/javascript/stylesheets/tailwind.config.js'),
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    })
  ]
};

module.exports = environment;
  JS
  run 'npx tailwindcss init --full'
  run 'mv tailwind.config.js app/javascript/stylesheets/tailwind.config.js'
end

def tailwind_layout
  tailwind_application_css
  tailwind_application_html
  tailwind_navbar
  tailwind_footer
end

def tailwind_application_html
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
  <body class="flex flex-col h-screen font-sans" >
    <%= render 'pages/navbar' %>
    <%= yield %>
    <%= render 'pages/footer' %>
    <%= javascript_pack_tag 'application' %>
  </body>
</html>
  HTML
end

def tailwind_application_css
  remove_file 'app/assets/stylesheets/application.css'
  file 'app/assets/stylesheets/application.scss', <<-SCSS
@import "font-awesome-sprockets";
@import "font-awesome";
  SCSS
  file 'app/javascript/stylesheets/application.scss', <<-SCSS
@import "tailwindcss/base";
@import "tailwindcss/components";
@import "tailwindcss/utilities";
  SCSS
  inject_into_file 'app/javascript/packs/application.js', <<-CODE
import "stylesheets/application"
  CODE
end

def tailwind_navbar
  file 'app/views/pages/_navbar.html.erb', <<-HTML
<header class="lg:px-16 px-6 bg-white flex flex-wrap items-center lg:py-0 py-2">
  <div class="flex-1 flex justify-between items-center">
    <div class="flex items-center">
      <a href="/" class="block lg:mr-4">
        <svg class="h-10 w-auto hidden md:block" viewBox="0 0 273 64" fill="none" xmlns="http://www.w3.org/2000/svg">
          <title>Tailwind CSS</title>
          <path fill="url(#paint0_linear)" fill-rule="evenodd" clip-rule="evenodd" d="M32 16C24.8 16 20.3 19.6 18.5 26.8C21.2 23.2 24.35 21.85 27.95 22.75C30.004 23.2635 31.4721 24.7536 33.0971 26.4031C35.7443 29.0901 38.8081 32.2 45.5 32.2C52.7 32.2 57.2 28.6 59 21.4C56.3 25 53.15 26.35 49.55 25.45C47.496 24.9365 46.0279 23.4464 44.4029 21.7969C41.7557 19.1099 38.6919 16 32 16ZM18.5 32.2C11.3 32.2 6.8 35.8 5 43C7.7 39.4 10.85 38.05 14.45 38.95C16.504 39.4635 17.9721 40.9536 19.5971 42.6031C22.2443 45.2901 25.3081 48.4 32 48.4C39.2 48.4 43.7 44.8 45.5 37.6C42.8 41.2 39.65 42.55 36.05 41.65C33.996 41.1365 32.5279 39.6464 30.9029 37.9969C28.2557 35.3099 25.1919 32.2 18.5 32.2Z"></path>
          <path fill="#2D3748" fill-rule="evenodd" clip-rule="evenodd" d="M85.996 29.652H81.284V38.772C81.284 41.204 82.88 41.166 85.996 41.014V44.7C79.688 45.46 77.18 43.712 77.18 38.772V29.652H73.684V25.7H77.18V20.596L81.284 19.38V25.7H85.996V29.652ZM103.958 25.7H108.062V44.7H103.958V41.964C102.514 43.978 100.272 45.194 97.308 45.194C92.14 45.194 87.846 40.824 87.846 35.2C87.846 29.538 92.14 25.206 97.308 25.206C100.272 25.206 102.514 26.422 103.958 28.398V25.7ZM97.954 41.28C101.374 41.28 103.958 38.734 103.958 35.2C103.958 31.666 101.374 29.12 97.954 29.12C94.534 29.12 91.95 31.666 91.95 35.2C91.95 38.734 94.534 41.28 97.954 41.28ZM114.902 22.85C113.458 22.85 112.28 21.634 112.28 20.228C112.28 18.784 113.458 17.606 114.902 17.606C116.346 17.606 117.524 18.784 117.524 20.228C117.524 21.634 116.346 22.85 114.902 22.85ZM112.85 44.7V25.7H116.954V44.7H112.85ZM121.704 44.7V16.96H125.808V44.7H121.704ZM152.446 25.7H156.778L150.812 44.7H146.784L142.832 31.894L138.842 44.7H134.814L128.848 25.7H133.18L136.866 38.81L140.856 25.7H144.77L148.722 38.81L152.446 25.7ZM161.87 22.85C160.426 22.85 159.248 21.634 159.248 20.228C159.248 18.784 160.426 17.606 161.87 17.606C163.314 17.606 164.492 18.784 164.492 20.228C164.492 21.634 163.314 22.85 161.87 22.85ZM159.818 44.7V25.7H163.922V44.7H159.818ZM178.666 25.206C182.922 25.206 185.962 28.094 185.962 33.034V44.7H181.858V33.452C181.858 30.564 180.186 29.044 177.602 29.044C174.904 29.044 172.776 30.64 172.776 34.516V44.7H168.672V25.7H172.776V28.132C174.03 26.156 176.082 25.206 178.666 25.206ZM205.418 18.1H209.522V44.7H205.418V41.964C203.974 43.978 201.732 45.194 198.768 45.194C193.6 45.194 189.306 40.824 189.306 35.2C189.306 29.538 193.6 25.206 198.768 25.206C201.732 25.206 203.974 26.422 205.418 28.398V18.1ZM199.414 41.28C202.834 41.28 205.418 38.734 205.418 35.2C205.418 31.666 202.834 29.12 199.414 29.12C195.994 29.12 193.41 31.666 193.41 35.2C193.41 38.734 195.994 41.28 199.414 41.28ZM223.278 45.194C217.54 45.194 213.246 40.824 213.246 35.2C213.246 29.538 217.54 25.206 223.278 25.206C227.002 25.206 230.232 27.144 231.752 30.108L228.218 32.16C227.382 30.374 225.52 29.234 223.24 29.234C219.896 29.234 217.35 31.78 217.35 35.2C217.35 38.62 219.896 41.166 223.24 41.166C225.52 41.166 227.382 39.988 228.294 38.24L231.828 40.254C230.232 43.256 227.002 45.194 223.278 45.194ZM238.592 30.944C238.592 34.402 248.814 32.312 248.814 39.342C248.814 43.142 245.508 45.194 241.404 45.194C237.604 45.194 234.868 43.484 233.652 40.748L237.186 38.696C237.794 40.406 239.314 41.432 241.404 41.432C243.228 41.432 244.634 40.824 244.634 39.304C244.634 35.922 234.412 37.822 234.412 31.02C234.412 27.448 237.49 25.206 241.366 25.206C244.482 25.206 247.066 26.65 248.396 29.158L244.938 31.096C244.254 29.614 242.924 28.93 241.366 28.93C239.884 28.93 238.592 29.576 238.592 30.944ZM256.11 30.944C256.11 34.402 266.332 32.312 266.332 39.342C266.332 43.142 263.026 45.194 258.922 45.194C255.122 45.194 252.386 43.484 251.17 40.748L254.704 38.696C255.312 40.406 256.832 41.432 258.922 41.432C260.746 41.432 262.152 40.824 262.152 39.304C262.152 35.922 251.93 37.822 251.93 31.02C251.93 27.448 255.008 25.206 258.884 25.206C262 25.206 264.584 26.65 265.914 29.158L262.456 31.096C261.772 29.614 260.442 28.93 258.884 28.93C257.402 28.93 256.11 29.576 256.11 30.944Z"></path>
          <defs>
            <linearGradient id="paint0_linear" x1="3.5" y1="16" x2="59" y2="48" gradientUnits="userSpaceOnUse">
              <stop stop-color="#2298BD"></stop>
              <stop offset="1" stop-color="#0ED7B5"></stop>


            </linearGradient>
          </defs>
        </svg>

        <svg class="w-10 h-10 block md:hidden" viewBox="0 0 64 64" xmlns="http://www.w3.org/2000/svg">
          <title>Tailwind CSS</title>
          <path d="M13.5 11.1C15.3 3.9 19.8.3 27 .3c10.8 0 12.15 8.1 17.55 9.45 3.6.9 6.75-.45 9.45-4.05-1.8 7.2-6.3 10.8-13.5 10.8-10.8 0-12.15-8.1-17.55-9.45-3.6-.9-6.75.45-9.45 4.05zM0 27.3c1.8-7.2 6.3-10.8 13.5-10.8 10.8 0 12.15 8.1 17.55 9.45 3.6.9 6.75-.45 9.45-4.05-1.8 7.2-6.3 10.8-13.5 10.8-10.8 0-12.15-8.1-17.55-9.45-3.6-.9-6.75.45-9.45 4.05z" transform="translate(5 16)" fill="url(#logoMarkGradient)" fill-rule="evenodd"></path>
          <defs>
            <linearGradient x1="0%" y1="0%" y2="100%" id="logoMarkGradient">
              <stop stop-color="#2298BD"></stop>
              <stop offset="1" stop-color="#0ED7B5"></stop>


            </linearGradient>
          </defs>
        </svg>
      </a>
    </div>
  </div>

  <label for="menu-toggle" class="pointer-cursor lg:hidden block"><svg class="fill-current text-gray-900" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 20 20"><title>menu</title><path d="M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z"></path></svg></label>
  <input class="hidden" type="checkbox" id="menu-toggle" />

  <div class="hidden lg:flex lg:items-center lg:w-auto w-full" id="menu">
    <nav>
      <ul class="lg:flex items-center justify-between text-base text-gray-700 pt-4 lg:pt-0">
        <li><a class="lg:p-4 py-3 px-0 block border-b-2 border-transparent hover:border-indigo-400" href="#">Features</a></li>
        <li><a class="lg:p-4 py-3 px-0 block border-b-2 border-transparent hover:border-indigo-400" href="#">Pricing</a></li>
        <li><a class="lg:p-4 py-3 px-0 block border-b-2 border-transparent hover:border-indigo-400" href="#">Documentation</a></li>
        <li><a class="lg:p-4 py-3 px-0 block border-b-2 border-transparent hover:border-indigo-400 lg:mb-0 mb-2" href="#">Support</a></li>
      </ul>
    </nav>
    <a href="#" class="lg:ml-4 flex items-center justify-start lg:mb-0 mb-4 pointer-cursor">
      <img class="rounded-full w-10 h-10 border-2 border-transparent hover:border-indigo-400" src="https://avatars3.githubusercontent.com/u/49295880?s=460&u=68356dea758480dd77e03a8e1a24dd6d6291adc5&v=4" alt="Naokimi">
    </a>
  </div>
</header>
  HTML
end

def tailwind_footer
  file 'app/views/pages/_footer.html.erb', <<-HTML
<footer class="bg-gray-100 text-gray-600">
  <div class="container mx-auto px-6 pt-10 pb-6">
  <div class="content has-text-centered">
    <p>
      <strong>Tailwind</strong> by <a href="https://github.com/tailwindcss/tailwindcss">the Tailwind contributors</a>. The source code is licensed
      <a href="http://opensource.org/licenses/mit-license.php">MIT</a>.
    </p>
    <p>
      Rails template made by <a href="https://github.com/Naokimi"><i class="fab fa-github"></i> Naokimi</a>
    </p>
  </div>
  </div>
</footer>
  HTML
end

def tailwind_homepage
  run 'rm app/views/pages/home.html.erb'
  file 'app/views/pages/home.html.erb', <<-HTML
<div class="flex-auto py-20 text-gray-700 bg-white" style="background: linear-gradient(90deg, #667eea 0%, #764ba2 100%)"
>
  <div class="container mx-auto px-6">
    <h2 class="text-4xl font-bold mb-2 text-white">
      <i class="fas fa-heart"></i> Tailwind Framework <i class="fas fa-heart"></i>
    </h2>
    <h3 class="text-2xl mb-8 text-gray-200">
      A highly customizable, low-level CSS framework. Discover how to <strong>customize</strong> it!
    </h3>

    <a class="bg-white font-bold rounded-full py-4 px-8 shadow-lg uppercase tracking-wider" href="https://tailwindcss.com/components">
      Documentation
    </a>
  </div>
</div>
  HTML
end

def tailwind_framework
  gems
  install_tailwind
  tailwind_layout

  after_bundle do
    tailwind_config_files
    homepage_controller
    tailwind_homepage
    simple_form_install
    generate_installs_and_migrate
    git_ignore
    commit_and_push
  end
end

def pick_option
  option = ask 'pick a number'

  case option
  when '1' then bootstrap_framework
  when '2' then bulma_framework
  when '3' then foundation_framework
  when '4' then tailwind_framework
  else
    say 'Error - please pick a number from the list'
    pick_option
  end
end

say '-- Welcome to Personal Projects Templates! --'
say 'a list of templates to experiment with different UI frameworks'
say
say 'please pick a template from the list:'
say '1 - Bootstrap:  The most popular HTML, CSS, and JS library in the world'
say '2 - Bulma:      A pure CSS framework based on Flexbox and built with Sass'
say '3 - Foundation: The most advanced responsive front-end framework in the world'
say '4 - Tailwind:   A utility-first CSS framework for rapidly building custom designs'
say

pick_option
