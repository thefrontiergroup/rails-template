class DeviseCustomisations::PasswordsController < Devise::PasswordsController

  def update
    super do |resource|
      # By default, Devise will ignore the password reset and sign the user in if they don't
      # provide a new password and submit the form.
      #
      # Instead, we want the form to display an error and force the user to reset their password.
      if params[resource_name][:password].blank?
        resource.errors.add(:password, "can't be blank")
      end
    end
  end

end
