source 'https://rubygems.org'

gem 'rails'

# Database & ORM
gem 'paranoia'
gem 'pg'
gem 'ransack'

# Authentication & Authorization
gem 'devise'
gem 'cancancan'

# Presentation
gem 'active_link_to'
gem 'autoprefixer-rails'
gem 'bourbon'
gem 'coffee-rails'
gem 'haml-rails'
gem 'jquery-rails'
gem 'jquery-timepicker-rails'
gem 'kaminari'
gem 'momentjs-rails'
gem 'neat'
gem 'normalize-rails'
gem 'page_title_helper'
gem 'sass-rails'
gem 'semantic-ui-sass'
gem 'simple_form'
gem 'uglifier'

# Misc
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
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'rspec-rails'
  gem 'rspec_junit_formatter'
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
end

group :test do
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'shoulda-matchers'
  gem 'timecop'
end

group :staging do
  # Enable "Staging" ribbon on top right corner
  gem 'rack-dev-mark'
end
