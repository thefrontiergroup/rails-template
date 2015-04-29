require 'fileutils'
require 'yaml'

desc "Setup config files for database, and secrets. Setup database"
task :spin_up do
  SpinUpHelper.new(:test).spin_up
end

desc "Setup config files for database, and secrets. Setup the test database."
task :spin_up_ci do
  SpinUpHelper.new(:test).spin_up
end

class SpinUpHelper
  CONFIGS = [
    "config/secrets.yml",
    "config/database.yml",
    "config/omniauth.yml",
    "config/redis.yml",
    "config/healthway.yml",
    "config/ldap.yml"
  ]

  def initialize(env)
    @env = env
  end

  def spin_up
    copy_samples
    setup_secrets_config
    setup_database
  end

private

  def copy_samples
    CONFIGS.each do |config|
      FileUtils.copy("#{config}.sample", config)
    end
  end

  def setup_secrets_config
    filename = "config/secrets.yml"
    yaml = YAML.load_file(filename)
    yaml["development"]["secret_key_base"] = SecureRandom.hex(64)
    yaml["test"]["secret_key_base"] = SecureRandom.hex(64)
    write_yaml(yaml, filename)
  end

  def setup_database
    if @env == :development
      command = "rake db:create db:migrate && rake db:seed"
    elsif @env == :test
      command = "RAILS_ENV=test rake db:drop db:create db:migrate"
    else
      raise "unknown environment"
    end
    puts "Running '#{command}'"
    # puts will output the output of the command to the user. Running the command alone
    # will swallow the output.
    puts `#{command}`
  end

  def write_yaml(hash, filename)
    File.open(filename, "w") {|file| file.write(hash.to_yaml)}
  end
end
