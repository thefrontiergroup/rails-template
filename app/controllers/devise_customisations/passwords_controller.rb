class DeviseCustomisations::PasswordsController < Devise::PasswordsController

  def edit
    flash.clear
    super
  end

  def update
    super do |resource|
      # By default, Devise will ignore the password reset and sign the user in if they don't
      # provide a new password and submit the form.
      #
      # Instead, we want the form to display an error and force the user to reset their password.
      if params[resource_name][:password].blank?
        resource.errors.add(:password, "can't be blank")
      end

      # When the reset_password_token passed from the form is invalid - ie: the user is trying
      # to reset their password from an old email, Devise returns a blank User for some reason.
      #
      # The downside to this is that if you put a valid password and confirmation in the form,
      # the User is invalid (because they are an empty User with only a password and confirmation).
      #
      # Instead, we want to show a more useful flash message.
      if !resource.persisted?
        flash.clear
        set_flash_message!(:alert, :invalid_token)
      end
    end
  end

end
