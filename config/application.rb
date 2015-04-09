require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TfgTemplate
  class Application < Rails::Application
    config.should_seed_application_data = false
    config.should_show_easy_login = false
  end
end
