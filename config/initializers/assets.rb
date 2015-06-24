# No need to conditionally compile assets - if we compile an asset and don't use it, it won't
# be served anyway.
#
Rails.application.config.assets.precompile += %w(
  admin.css
  easy_sign_in.js
  public.css
)