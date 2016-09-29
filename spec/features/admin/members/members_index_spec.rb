require 'rails_helper'

feature 'Admin can view an index of users' do

  signed_in_as(:admin) do
    let!(:member) { FactoryGirl.create(:user, :member) }

    before do
      click_sidemenu_option("Dashboard")
      click_sidemenu_option("Members")
    end

    scenario "Showing members" do
      expect(page).to have_content(member.email)
      expect(page).not_to have_content(current_user.email)
    end
  end

end
