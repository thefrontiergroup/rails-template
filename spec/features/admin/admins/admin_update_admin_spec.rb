require 'rails_helper'

feature 'Admin can update an existing User' do

  signed_in_as(:admin) do
    let!(:target_user) { FactoryGirl.create(:user, :admin, email: "something@nothing.com") }

    before do
      click_header_option("Dashboard")
      click_sidemenu_option("Admins")
      within_row(target_user.email) do
        click_link("Edit")
      end
    end

    scenario 'Admin updates user with valid data' do
      fill_in("Email", with: "valid@example.com")
      click_button("Save Changes")

      # Current user should be redirected to the index
      expect(current_path).to eq(admin_admins_path)

      # User should be saved
      latest_user = User.order(:created_at).last
      expect(latest_user.email).to eq("valid@example.com")
      expect(latest_user).to be_admin
    end

    scenario 'Admin updates user with invalid data' do
      fill_in("Email", with: "")
      click_button("Save Changes")

      # Ensure user is not updated
      expect(target_user.reload.email).to eq("something@nothing.com")
      expect(page).to have_error_message("user_email", "can't be blank")
    end
  end
end
