if Rails.application.config.should_show_easy_login
  Rails.application.config.assets.precompile += %w( easy_sign_in.js )
end