# frozen_string_literal: true

def foundation_gems
  gem 'foundation-rails'
end

def generate_foundation
  generate 'foundation:install'
end

def simple_form_install
  generate('simple_form:install', '--foundation')
end

def foundation_layout
  application_css
  application_html
  foundation_navbar
  foundation_footer
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
  foundation_gems
  foundation_layout

  after_bundle do
    homepage_controller
    foundation_homepage
    simple_form_install
    generate_foundation
    generate_installs_and_migrate
    git_ignore
    commit_and_push
  end
end
