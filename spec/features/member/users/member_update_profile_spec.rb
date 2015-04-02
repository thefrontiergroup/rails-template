require 'spec_helper'

feature 'Member can update their profile' do

  sign_in_as(:member)

  before do
    click_link("My Profile")
  end

  scenario 'With valid data' do
    fill_in("Email", with: "valid@example.com")
    click_button("Update User")

    # User should be saved
    click_link("My Profile")
    expect(page).to have_content("valid@example.com")
  end

  scenario 'With invalid data' do
    fill_in("Email", with: "")
    click_button("Update User")

    expect(page).to have_content("can't be blank")
  end
end
