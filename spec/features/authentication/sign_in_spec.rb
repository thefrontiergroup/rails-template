require 'spec_helper'

feature 'A user can sign in' do

  background do
    FactoryGirl.create(:user, email: "email@example.com", password: "password")
    visit root_path
    click_link 'Sign in'
  end

  scenario 'User signs in with valid credentials' do
    fill_in("Email", with: "email@example.com")
    fill_in("Password", with: "password")

    submit_form

    expect(page).to have_flash :notice, /Signed in/
    expect(current_path).to eq(root_path)
  end

  scenario "User attempts to sign in with invalid credentials" do
    submit_form

    expect(page).to have_flash :alert, /Invalid email or password./
  end
end
