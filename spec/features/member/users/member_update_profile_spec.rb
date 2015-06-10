require 'rails_helper'

feature 'Member can update their profile' do

  sign_in_as(:member)

  before do
    click_header_option("My Profile")
  end

  scenario 'With valid data' do
    fill_in("Email", with: "valid@example.com")
    click_button("Update User")

    # User should be saved
    click_header_option("My Profile")
    expect(current_user.reload.email).to eq("valid@example.com")
  end

  scenario 'With invalid data' do
    fill_in("Email", with: "")
    click_button("Update User")

    expect(page).to have_content("can't be blank")
  end
end
