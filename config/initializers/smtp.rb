options = YAML.load_file(Rails.root.join('config', 'smtp.yml'))[Rails.env]

if options.present?
  ActionMailer::Base.delivery_method = Rails.env.test? ? :test : :smtp
  ActionMailer::Base.smtp_settings = options
elsif !Rails.env.test?
  raise "Please setup e-mail settings for #{Rails.env}"
end
