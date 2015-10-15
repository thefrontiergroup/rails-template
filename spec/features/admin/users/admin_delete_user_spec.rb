require 'rails_helper'

feature 'Admin can delete an existing User' do

  signed_in_as(:admin) do
    let!(:target_user) { FactoryGirl.create(:user, email: "something@nothing.com") }

    before do
      click_header_option("Dashboard")
      click_sidemenu_option("Users")
    end

    scenario 'Admin can delete user' do
      within_row(target_user.email) do
        click_link("Delete")
      end

      # User should be deleted - only admin should be visible
      expect(User.count).to eq(1)
      expect(page).to have_flash(:notice, "'something@nothing.com' deleted")
    end
  end
end
