class DeviseCustomisations::RegistrationsController < Devise::RegistrationsController

  def build_resource(args)
    super.tap do |user|
      user.role = User.roles["member"]
    end
  end

end