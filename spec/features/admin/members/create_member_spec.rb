require 'rails_helper'

feature 'Admin can create a new User' do

  signed_in_as(:admin) do
    before do
      click_sidemenu_option("Dashboard")
      click_sidemenu_option("Members")
      click_link("Add new member")
    end

    scenario 'Admin creates user with valid data' do
      fill_in("Given names", with: "Jordan")
      fill_in("Family name", with: "Maguire")
      fill_in("Email", with: "valid@example.com")
      fill_in("Password", with: "password")
      click_button("Create")

      # Current user should be redirected to the index
      expect(current_path).to eq(admin_members_path)

      # User should be saved
      latest_user = User.member.order(created_at: :desc).first
      expect(latest_user).to be_present
      expect(latest_user.email).to eq("valid@example.com")
      expect(latest_user.given_names).to eq("Jordan")
      expect(latest_user.family_name).to eq("Maguire")
    end

    scenario 'Admin creates user with invalid data' do
      fill_in("Given names", with: "")
      fill_in("Family name", with: "")
      fill_in("Email", with: "")
      fill_in("Password", with: "")
      click_button("Create")

      # Ensure no user is created
      expect(page).to have_content("User could not be created.")
      expect(User.count).to eq(1)
      expect(page).to have_error_message(:given_names, "can't be blank")
      expect(page).to have_error_message(:email, "can't be blank")
    end
  end
end
