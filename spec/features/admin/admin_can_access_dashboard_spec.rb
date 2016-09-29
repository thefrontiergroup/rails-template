require 'rails_helper'

feature 'Admin can access their dashboard' do

  signed_in_as(:admin) do
    scenario 'User clicks "Dashboard" link' do
      click_sidemenu_option("Dashboard")
      expect(page).to have_content("Admin Dashboard")
    end
  end
end
