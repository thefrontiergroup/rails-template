require 'rails_helper'

feature 'Admin can create a new User' do

  signed_in_as(:admin) do
    before do
      click_header_option("Dashboard")
      click_sidemenu_option("Admins")
      click_link("Add new admin")
    end

    scenario 'Admin creates user with valid data' do
      fill_in("Email", with: "valid@example.com")
      fill_in("Password", with: "password")
      click_button("Create")

      # Current user should be redirected to the index
      expect(current_path).to eq(admin_admins_path)

      # User should be saved
      latest_user = User.find_by(email: "valid@example.com")
      expect(latest_user).to be_present
      expect(latest_user).to be_admin
    end

    scenario 'Admin creates user with invalid data' do
      fill_in("Email", with: "")
      fill_in("Password", with: "")
      click_button("Create")

      # Ensure no user is created
      expect(page).to have_content("User could not be created.")
      expect(page).to have_error_message("user_email", "can't be blank")
      expect(User.count).to eq(1)
    end
  end
end
