require 'fileutils'
require 'yaml'

desc "Setup config files for database, and secrets. Setup database"
task :spin_up do
  configs = ["config/secrets.yml", "config/database.yml"]

  helper = SpinUpHelper.new
  if helper.warning_prompt(configs)
    helper.copy_samples(configs)
    helper.setup_secrets_config
    helper.setup_database
  end
end

class SpinUpHelper

  def warning_prompt(configs)
    print "This will clobber your existing: \n"
    configs.each { |config| print "\t#{config}\n" }
    print "Do you wish to proceed (y/n)\n"
    STDOUT.flush
    prompt_is_yes?
  end

  def copy_samples(configs)
    configs.each do |config|
      FileUtils.copy("#{config}.sample", config)
    end
  end

  def setup_secrets_config
    filename = "config/secrets.yml"
    yaml = YAML.load_file(filename)
    yaml["development"]["secret_key_base"] = SecureRandom.hex(128)
    yaml["test"]["secret_key_base"] = SecureRandom.hex(128)
    write_yaml(yaml, filename)
  end

  def setup_database
    command = "rake db:create db:migrate && rake db:seed"
    puts "Running '#{command}'"
    # puts will output the output of the command to the user. Running the command alone
    # will swallow the output.
    puts `#{command}`
  end

private

  def prompt_is_yes?
    response = STDIN.gets
    response.length > 0 && response[0].downcase == "y"
  end

  def write_yaml(hash, filename)
    File.open(filename, "w") {|file| file.write(hash.to_yaml)}
  end

end
