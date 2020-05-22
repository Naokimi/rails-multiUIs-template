# frozen_string_literal: true

gem_group :development, :test do
  gem 'annotate'
  gem 'rspec'
end

after_bundle do
  rails_command('g annotate:install')

  rails_command('db:create')
  rails_command('db:migrate')

  git(:init)
  git(add: '.')
  git(commit: %( -m 'Initial commit using personal-projects-template' ))
end
