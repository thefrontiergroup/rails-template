require 'spec_helper'

feature 'Member can access their dashboard' do

  sign_in_as(:member)

  scenario 'User clicks "Dashboard" link' do
    click_header_option "Dashboard"
    expect(page).to have_content("Member Dashboard")
  end
end
