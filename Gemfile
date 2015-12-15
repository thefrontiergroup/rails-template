source 'https://rubygems.org'

gem 'rails'

# Database & ORM
gem 'paranoia'
gem 'pg'
gem 'rails_sort', github: "thefrontiergroup/rails_sort"

# Authentication & Authorization
gem 'devise'
gem 'pundit'

# Presentation
gem 'coffee-rails'
gem 'haml-rails'
gem 'jquery-rails'
gem 'jquery-timepicker-rails'
gem 'momentjs-rails'
gem 'kaminari'
gem 'normalize-rails'
gem 'sass-rails'
gem 'simple_form'
gem 'uglifier'
gem 'bourbon'
gem 'neat'

gem 'responders'

group :development do
  gem 'better_errors'
  gem 'letter_opener'
  gem 'quiet_assets'
  gem 'seed_helper'
  gem 'tfg_cap', git: 'git@github.com:thefrontiergroup/tfg-cap.git', require: nil
  gem 'web-console'
end

group :development, :test do
  gem 'byebug'
  # RSpec for unit and integration tests
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
  gem 'capybara'
  gem 'capybara-screenshot'
  # Generate fake data for seeds and tests
  gem 'factory_girl_rails'
  gem 'ffaker'
end

group :test do
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'shoulda-matchers', '~> 2.8.0'
end

group :staging do
  # Enable "Staging" ribbon on top right corner
  gem 'rack-dev-mark'
end
