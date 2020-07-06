
# Bulma Framework

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
