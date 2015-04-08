require 'spec_helper'

feature 'Admin can update an existing User' do

  sign_in_as(:admin)
  let!(:target_user) { FactoryGirl.create(:user, email: "something@nothing.com") }

  before do
    click_header_option("Dashboard")
    click_sidemenu_option("Users")
    within_row(target_user.email) do
      click_link("Edit")
    end
  end

  scenario 'Admin updates user with valid data' do
    fill_in("Email", with: "valid@example.com")
    select("Member", from: "Role")
    click_button("Update User")

    # Current user should be redirected to the index
    expect(current_path).to eq(admin_users_path)

    # User should be saved
    latest_user = User.order(:created_at).last
    expect(latest_user.email).to eq("valid@example.com")
    expect(latest_user).to be_member
  end

  scenario 'Admin updates user with invalid data' do
    fill_in("Email", with: "")
    click_button("Update User")

    # Ensure user is not updated
    expect(target_user.reload.email).to eq("something@nothing.com")
    expect(page).to have_content("can't be blank")
  end
end
