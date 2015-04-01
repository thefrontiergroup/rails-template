require 'spec_helper'

feature 'Admin can update an existing User' do

  sign_in_as(:admin)
  let!(:target_user) { FactoryGirl.create(:user, email: "something@nothing.com") }

  before do
    click_link("Dashboard")
    click_link("Users")
    within_row(target_user.email) do
      click_link("Edit")
    end
  end

  scenario 'Admin updates user with valid data' do
    fill_in("Email", with: "valid@example.com")
    select("Member", from: "Role")
    click_button("Update User")

    # User should be saved
    expect(page).to have_content("valid@example.com")
    latest_user = User.order(:created_at).last
    expect(latest_user).to be_member
  end

  scenario 'Admin updates user with invalid data' do
    fill_in("Email", with: "")
    click_button("Update User")

    expect(page).to have_content("can't be blank")
  end
end
