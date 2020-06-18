# frozen_string_literal: true

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
  run 'mkdir app/javascript/stylesheets/'
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
  <body class="bg-black text-white font-sans">

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

  HTML
end

def tailwind_footer
  file 'app/views/pages/_footer.html.erb', <<-HTML

  HTML
end

def tailwind_homepage
  run 'rm app/views/pages/home.html.erb'
  file 'app/views/pages/home.html.erb', <<-HTML

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
