require 'rails_helper'

feature 'Admin can access their dashboard' do

  sign_in_as(:admin)

  scenario 'User clicks "Dashboard" link' do
    click_header_option "Dashboard"
    expect(page).to have_content("Admin Dashboard")
  end
end
