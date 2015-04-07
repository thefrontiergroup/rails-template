source 'https://rubygems.org'

gem 'rails'

# Database & ORM
gem 'paranoia'
gem 'pg'

# Authentication & Authorization
gem 'devise'
gem 'pundit'

# Presentation
gem 'coffee-rails'
gem 'haml-rails'
gem 'jquery-rails'
gem 'kaminari'
gem 'normalize-rails'
gem 'sass-rails'
gem 'simple_form'
gem 'uglifier'


group :development do
  # Quiet Assets hides all of the asset logging in Development.
  gem 'quiet_assets'
  gem 'seed_helper'
  gem 'spring'
end

group :test do
  gem 'email_spec'
  gem 'shoulda-matchers'
end

group :development, :test do
  # byebug allows user of the `debugger` key word
  gem 'byebug'
  # RSpec for unit and integration tests
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
  gem 'capybara'
  # Generate fake data for seeds and tests
  gem 'factory_girl_rails'
  gem 'ffaker'
end
