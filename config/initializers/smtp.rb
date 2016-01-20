options = YAML.load_file(Rails.root.join('config', 'smtp.yml'))[Rails.env]

if options.present?
  Rails.application.config.action_mailer.smtp_settings = options.with_indifferent_access
end
