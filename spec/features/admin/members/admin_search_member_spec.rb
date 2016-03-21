require 'rails_helper'

feature 'Admin can search for members by email' do

  signed_in_as(:admin) do
    let!(:member) { FactoryGirl.create(:user, :member) }

    before do
      click_header_option("Dashboard")
      click_sidemenu_option("Members")
    end

    scenario "Search with matching data" do
      fill_in('Search by email', with: member.email)
      click_button('Search')
      expect(page).to have_content(member.email)
      expect(page).not_to have_content(current_user.email)
    end

    scenario "Search with non-matching data" do
      fill_in('Search by email', with: current_user.email)
      click_button('Search')
      expect(page).to have_content("No users matched your search")
      expect(page).not_to have_content(current_user.email)
    end
  end

end
