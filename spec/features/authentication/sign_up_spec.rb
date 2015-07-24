require 'rails_helper'

feature 'A visitor can sign up' do

  background do
    visit root_path
    click_link 'Sign up'
  end

  scenario 'User signs up successfully' do
    fill_in("Email", with: "email@example.com")
    fill_in("user_password", with: "password", exact: true)
    fill_in("Password confirmation", with: "password")

    submit_form

    expect(page).to have_flash :notice, /signed up/
    expect(current_path).to eq(member_dashboard_index_path)

    # Signing up should create the user as a member
    expect(User.first).to be_member
  end

  scenario "User doesn't fill in details" do
    submit_form
    within("form") do
      # Errors show below the inputs, Capybara will show the error as follows
      expect(page).to have_error_message("user_email", "can't be blank")
      expect(page).to have_error_message("user_password", "can't be blank")
      expect(page).to have_hint_message("user_password", "Minimum is #{Rails.configuration.devise.password_length.min} characters")
    end
  end
end
