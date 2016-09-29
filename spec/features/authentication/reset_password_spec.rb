require 'rails_helper'

feature 'Existing users can reset their passwords' do
  let(:user) { FactoryGirl.create(:user) }

  background do
    visit(root_path)
    click_header_option('Sign in')
    click_link('Forgot your password?')
  end

  scenario 'User enters a valid email address' do
    fill_in 'Email', with: user.email
    submit_form

    open_email(user.email)
    visit_in_email 'Change my password'

    fill_in 'New password', with: 'password'
    fill_in 'Confirm new password', with: 'password'
    submit_form

    expect(page).to have_flash :notice, /password was changed/
  end

  scenario 'User enters an invalid email address' do
    fill_in 'Email', with: 'fake@email.com'
    submit_form
    within("form") do
      expect(page).to have_content("Email not found")
    end
  end
end
