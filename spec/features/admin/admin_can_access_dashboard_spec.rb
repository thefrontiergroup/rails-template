require 'spec_helper'

feature 'Admin can access their dashboard' do

  sign_in_as(:admin)

  scenario 'User clicks "Dashboard" link' do
    click_link "Dashboard"
    expect(page).to have_content("Admin Dashboard")
  end
end
