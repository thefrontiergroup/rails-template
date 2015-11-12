require 'rails_helper'

feature 'Admin can search for users by email' do

  signed_in_as(:admin) do
    let!(:member) { FactoryGirl.create(:user, :member) }

    before do
      click_header_option("Dashboard")
      click_sidemenu_option("Members")
    end

    scenario "Search with matching data" do
      fill_in('Email', with: member.email)
      click_button('Search')
      expect(page).to have_content(member.email)
      expect(page).not_to have_content(current_user.email)
    end

    scenario "Search with non-matching data" do
      fill_in('Email', with: current_user.email)
      click_button('Search')
      expect(page).to have_content("No users matched that search")
      expect(page).not_to have_content(current_user.email)
    end
  end

end