source 'https://rubygems.org'

gem 'rails'

# Use PostgreSQL as the database for ActiveRecord
gem 'pg'

# Authentication & Authorization
gem 'devise'
gem 'pundit'

# Use HAML and SASS
gem 'haml-rails'
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

group :development do
  gem 'seed_helper'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Quiet Assets hides all of the asset logging in Development.
  gem 'quiet_assets'
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
