# frozen_string_literal: true

def bootstrap_install
  run 'yarn add popper.js jquery bootstrap'
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
  file 'app/assets/stylesheets/config/_bootstrap_variables.scss', <<-CSS
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

  CSS
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
    simple_form_install
    generate_installs_and_migrate
    git_ignore
    commit_and_push
  end
end
