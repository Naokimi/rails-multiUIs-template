# frozen_string_literal: true

def bootstrap_install
  run 'yarn add popper.js jquery bootstrap'
end

def bootstrap_layout
  bootstrap_assets
  bootstrap_application_js
  application_html
  bootstrap_navbar
  bootstrap_footer
end

def bootstrap_assets
  run 'rm -rf app/assets/stylesheets'
  run 'rm -rf vendor'
  run 'curl -L https://github.com/lewagon/stylesheets/archive/master.zip > stylesheets.zip'
  run 'unzip stylesheets.zip -d app/assets && rm stylesheets.zip && mv app/assets/rails-stylesheets-master app/assets/stylesheets'
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

def bootstrap_navbar
  file 'app/views/pages/_navbar.html.erb', <<-HTML
  HTML
end

def bootstrap_footer
  file 'app/views/pages/_footer.html.erb', <<-HTML
  HTML
end

def bootstrap_homepage
  # run 'rm app/views/pages/home.html.erb'
  # file 'app/views/pages/home.html.erb', <<-HTML
  #   <section class="hero is-primary">
  #     <div class="hero-body">
  #       <div class="container">
  #         <h1 class="title">
  #           <i class="fas fa-heart"></i> Bulma Framework <i class="fas fa-heart"></i>
  #         </h1>
  #         <h2 class="subtitle">
  #           A framework without any JavaScript. Discover how to <strong>customize</strong> it!
  #         </h2>
  #         <p>
  #           <a class="button is-light" href="https://bulma.io/documentation/overview/start/">Documentation</a>
  #         </p>
  #       </div>
  #     </div>
  #   </section>
  # HTML
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
