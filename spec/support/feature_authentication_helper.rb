module FeatureAuthenticationHelper

  def sign_in_as(role_or_user = :public_user)
    if role_or_user.is_a?(User)
      @current_user = role_or_user
    else
      @current_user = FactoryGirl.create :user, role_or_user
    end

    visit root_path
    click_link("Sign in")
    fill_in 'Email', with: @current_user.email
    fill_in 'Password', with: @current_user.password
    submit_form
  end

end
