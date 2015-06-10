require 'rails_helper'

feature 'Admin can create a new User' do

  sign_in_as(:admin)

  before do
    click_header_option("Dashboard")
    click_sidemenu_option("Users")
    click_link("Add new User")
  end

  scenario 'Admin creates user with valid data' do
    fill_in("Email", with: "valid@example.com")
    select("Member", from: "Role")
    fill_in("Password", with: "password")
    click_button("Create User")

    # Current user should be redirected to the index
    expect(current_path).to eq(admin_users_path)

    # User should be saved
    latest_user = User.order(:created_at).last
    expect(latest_user.email).to eq("valid@example.com")
    expect(latest_user).to be_member
  end

  scenario 'Admin creates user with invalid data' do
    fill_in("Email", with: "")
    select("Member", from: "Role")
    fill_in("Password", with: "")
    click_button("Create User")

    # Ensure no user is created
    expect(User.count).to eq(1)
    expect(page).to have_content("can't be blank")
  end
end
