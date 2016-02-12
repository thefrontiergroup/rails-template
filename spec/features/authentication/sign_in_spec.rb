require 'rails_helper'

feature 'A user can sign in' do

  background do
    visit root_path
    click_link 'Sign in'
  end

  context "As admin" do
    let!(:user) { FactoryGirl.create(:user, :admin) }

    scenario 'Admin signs in with valid credentials' do
      expect_sign_in_to_redirect_to(user, admin_dashboard_index_path)
    end
  end

  context "As member" do
    let!(:user) { FactoryGirl.create(:user, :member) }

    scenario 'Member signs in with valid credentials' do
      expect_sign_in_to_redirect_to(user, member_dashboard_index_path)
    end
  end

  scenario "User attempts to sign in with invalid credentials" do
    submit_form
    expect(page).to have_flash :alert, /Invalid email or password./
  end

private

  def expect_sign_in_to_redirect_to(user, path)
    fill_in("Email", with: user.email)
    fill_in("Password", with: user.password)

    submit_form

    expect(page).to have_flash :notice, /Signed in/
    expect(current_path).to eq(path)
  end
end
