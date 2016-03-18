RSpec.configure do |config|
  # Warden test mode speeds up tests, since you no longer need to
  # visit the login page to perform the authentication before feature tests
  config.before(:suite) do
    Warden.test_mode!
  end

  config.after(:each) do
    Warden.test_reset!
  end
end
