# frozen_string_literal: true

def install_tailwind
  run 'yarn add tailwindcss --dev'
end

def tailwind_layout
  tailwind_application_css
  application_html
  tailwind_navbar
  tailwind_footer
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
    homepage_controller
    tailwind_homepage
    simple_form_install
    generate_installs_and_migrate
    git_ignore
    commit_and_push
  end
end
