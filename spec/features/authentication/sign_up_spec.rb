require 'spec_helper'

feature 'A visitor can sign up' do

  background do
    visit root_path
    click_link 'Sign up'
  end

  scenario 'User signs up successfully' do
    fill_in("Email", with: "email@example.com")
    fill_in("Password", with: "password")
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
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
    end
  end
end
