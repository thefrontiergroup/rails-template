require 'rails_helper'

feature 'A user can sign in' do

  background do
    visit root_path
    click_link 'Sign in'
  end

  context "As admin" do
    background { FactoryGirl.create(:user, :admin, email: "email@example.com", password: "password") }

    scenario 'Admin signs in with valid credentials' do
      expect_sign_in_to_redirect_to(admin_dashboard_index_path)
    end
  end

  context "As member" do
    background { FactoryGirl.create(:user, :member, email: "email@example.com", password: "password") }

    scenario 'Member signs in with valid credentials' do
      expect_sign_in_to_redirect_to(member_dashboard_index_path)
    end
  end

  scenario "User attempts to sign in with invalid credentials" do
    submit_form
    expect(page).to have_flash :alert, /Invalid email or password./
  end

private

  def expect_sign_in_to_redirect_to(path)
    fill_in("Email", with: "email@example.com")
    fill_in("Password", with: "password")

    submit_form

    expect(page).to have_flash :notice, /Signed in/
    expect(current_path).to eq(path)
  end
end
