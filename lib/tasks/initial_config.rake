require 'fileutils'
require 'yaml'

desc "Setup config files for database, secrets and amazon"
task :initial_config do
  configs = ["config/secrets.yml", "config/database.yml"]
  if warning_prompt(configs)
    copy_samples(configs)
    setup_database
    setup_secrets
  end
end

def warning_prompt(configs)
  print "This will clobber your exsting: \n"
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

def setup_database
  filename = "config/database.yml"
  yaml = YAML.load_file(filename)

  write_yaml(yaml, filename)
end

def setup_secrets
  filename = "config/secrets.yml"
  yaml = YAML.load_file(filename)
  yaml["development"]["secret_key_base"] = SecureRandom.hex(30)
  yaml["test"]["secret_key_base"] = SecureRandom.hex(30)
  write_yaml(yaml, filename)
end

def prompt_is_yes?
  response = STDIN.gets
  response.length > 0 && response[0].downcase == "y"
end

def write_yaml(hash, filename)
  File.open(filename, "w") {|file| file.write(hash.to_yaml)}
end