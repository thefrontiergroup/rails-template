# Configure our /health_check endpoint do know the app is actually running ok

HealthCheck.setup do |config|

  # Text output on success
  config.success = "success"

  config.standard_checks = [ 'database', 'migrations', 'custom' ]
  config.full_checks = [ 'database', 'migrations', 'custom', 'email', 'cache' ]
  
  config.smtp_timeout = 30.0

  config.http_status_for_error_text = 503
  config.http_status_for_error_object = 503

  # We can add any custom checks here. Method must return a blank string for ok
  # or an error message
  #
  #config.add_custom_check do
  #   CustomClass.perform_health_check 
  #end
end
