# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'spec_helper'
require 'simplecov'
require 'simplecov-rcov'

SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start 'rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  config.infer_spec_type_from_file_location!

  # Warden test mode speeds up tests, since you no longer need to
  # visit the login page to perform the authentication before feature tests
  config.before(:suite) do
    Warden.test_mode!
  end

  config.after(:each) do
    Warden.test_reset!
  end

  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)

  # Controllers
  config.include Devise::TestHelpers, type: :controller
  config.extend ControllerAuthenticationSupport, type: :controller
  config.include ControllerParameterSupport, type: :controller
  config.extend ControllerDescribeAssignsHelper, type: :controller

  # Features
  config.include FeatureHelper, type: :feature
  config.include FeatureAuthenticationHelper, type: :feature
  config.include FeatureNavigationHelper, type: :feature
  config.extend FeatureAuthenticationMacros, type: :feature
  config.include Warden::Test::Helpers
end
