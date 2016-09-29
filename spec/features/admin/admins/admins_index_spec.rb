require 'rails_helper'

feature 'Admin can view an index of users' do

  signed_in_as(:admin) do
    let!(:other_admin) { FactoryGirl.create(:user, :admin) }
    let!(:member)      { FactoryGirl.create(:user, :member) }

    before do
      click_sidemenu_option("Dashboard")
      click_sidemenu_option("Admins")
    end

    scenario "Showing admins" do
      expect(page).to have_content(other_admin.email)
      expect(page).not_to have_content(member.email)
    end
  end

end
