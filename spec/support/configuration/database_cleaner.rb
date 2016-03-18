RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each, js: true) do |ex|
    DatabaseCleaner.strategy = :truncation
    ex.run
    DatabaseCleaner.strategy = :transaction
  end

  config.around(:each, truncation: true) do |ex|
    DatabaseCleaner.strategy = :truncation
    ex.run
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do |example|
    DatabaseCleaner.clean
  end

end
