# frozen_string_literal: true

gem_group :development, :test do
  gem 'annotate'
  gem 'rspec'
end

rails_command('g annotate:install')
