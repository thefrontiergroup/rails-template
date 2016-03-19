require 'rails_helper'

feature 'Admin can search for admins by email' do

  signed_in_as(:admin) do
    let!(:matching_admin) { FactoryGirl.create(:user, :admin) }

    before do
      click_header_option("Dashboard")
      click_sidemenu_option("Admins")
    end

    scenario "Search with matching data" do
      expect(page).to have_content(matching_admin.email)
      expect(page).to have_content(current_user.email)

      fill_in('Email', with: matching_admin.email)
      click_button('Search')

      expect(page).to have_content(matching_admin.email)
      expect(page).not_to have_content(current_user.email)
    end

    scenario "Search with non-matching data" do
      fill_in('Email', with: "jordan@example.com")
      click_button('Search')

      expect(page).to have_content("No users matched your search")
      expect(page).not_to have_content(current_user.email)
    end
  end

end
