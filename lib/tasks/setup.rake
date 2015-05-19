require 'fileutils'

namespace :setup do
  desc "Set random keys in the config/secrets.yml"
  task :randomize_secrets do
    filename = "config/secrets.yml"
    yaml = YAML.load_file(filename)
    yaml["development"]["secret_key_base"] = SecureRandom.hex(64)
    yaml["test"]["secret_key_base"] = SecureRandom.hex(64)
    File.open(filename, "w") {|file| file.write(yaml.to_yaml)}
  end
end
