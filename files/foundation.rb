
# Foundation Framework

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
  <body class="grid-x align-center" style="min-height: 100vh;">
    <div class="align-self-top">
      <%= render 'pages/navbar' %>
    </div>
    <div class="align-self-stretch" style="max-width: 80vw;">
      <%= yield %>
    </div>
    <div class="align-self-bottom text-center">
      <%= render 'pages/footer' %>
    </div>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
  </body>
</html>
  HTML
end

def foundation_navbar
  file 'app/views/pages/_navbar.html.erb', <<-HTML
<div class="top-bar" style="min-width: 100vw;">
  <div class="top-bar-left">
    <ul class="dropdown menu" data-dropdown-menu>
      <li class="menu-text">Foundation</li>
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
    <strong>Foundation</strong> by <a href="https://get.foundation/get-involved/contribute.html">the Foundation contributors</a>. The source code is licensed
    <a href="http://opensource.org/licenses/mit-license.php">MIT</a>.
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
