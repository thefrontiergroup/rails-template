require 'rails_helper'

feature 'Admin can update an existing User' do

  signed_in_as(:admin) do
    let!(:target_user) { FactoryGirl.create(:user, :member, email: "something@nothing.com") }

    before do
      click_sidemenu_option("Dashboard")
      click_sidemenu_option("Members")
      within_row(target_user.email) do
        click_link("Edit")
      end
    end

    scenario 'Admin updates user with valid data' do
      fill_in("Given names", with: "Jordan")
      fill_in("Family name", with: "Maguire")
      fill_in("Email", with: "valid@example.com")
      click_button("Save Changes")

      # Current user should be redirected to the index
      expect(current_path).to eq(admin_members_path)

      # User should be saved
      target_user.reload
      expect(target_user.email).to eq("valid@example.com")
      expect(target_user.given_names).to eq("Jordan")
      expect(target_user.family_name).to eq("Maguire")
    end

    scenario 'Admin updates user with invalid data' do
      fill_in("Given names", with: "")
      fill_in("Family name", with: "")
      fill_in("Email", with: "")
      click_button("Save Changes")

      # Ensure user is not updated
      expect(page).to have_content("User could not be updated.")
      expect(target_user.reload.email).to eq("something@nothing.com")
      expect(page).to have_error_message(:given_names, "can't be blank")
      expect(page).to have_error_message(:email, "can't be blank")
    end
  end
end
