# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'spec_helper'
require 'simplecov'
require 'simplecov-rcov'
require 'capybara-screenshot/rspec'
require 'database_cleaner'

SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start 'rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

Capybara::Screenshot.prune_strategy = :keep_last_run
Capybara::Screenshot.autosave_on_failure = true

RSpec.configure do |config|
  # Must be false for DatabaseCleaner
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!

  # General
  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)

  # Controllers
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.extend Controller::AuthenticationSupport, type: :controller
  config.include Controller::ParameterSupport, type: :controller
  config.extend Controller::DescribeAssignsSupport, type: :controller

  # Features
  config.include Feature::Support, type: :feature
  config.include Feature::AuthenticationSupport, type: :feature
  config.include Feature::NavigationSupport, type: :feature
  config.include Feature::PikadaySupport, type: :feature
  config.include Feature::SortSupport, type: :feature
  config.include Feature::TableSupport, type: :feature
  config.include Feature::RowLocationSupport, type: :feature
  config.include Warden::Test::Helpers

  config.extend Feature::AuthenticationMacros, type: :feature
end
