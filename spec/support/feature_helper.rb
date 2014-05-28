module FeatureHelper

  def sign_in
    @current_user = FactoryGirl.create(:user)

    visit root_path
    click_link("Sign in")
    fill_in 'Email', with: @current_user.email
    fill_in 'Password', with: @current_user.password
    submit_form
  end

  def submit_form
    find('input[name="commit"]').click
  end

end
