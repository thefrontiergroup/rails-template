require 'rails_helper'

feature 'Member can access their dashboard' do

  signed_in_as(:member) do
    scenario 'User clicks "Dashboard" link' do
      click_header_option("Dashboard")
      expect(page).to have_content("My Dashboard")
    end
  end

end
