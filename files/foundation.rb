# frozen_string_literal: true

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
