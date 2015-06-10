class DeviseCustomisations::RegistrationsController < Devise::RegistrationsController

  def build_resource(args)
    super.tap do |user|
      user.role = User.roles["member"]
    end
  end

protected

  def after_update_path_for(resource)
    # after user edits their own profile, we redirect to the same place
    # user's get redirect when sign in (usually dashboard)
    after_sign_in_path_for(resource)
  end
end