require 'rails_helper'

feature 'Member can update their profile' do

  signed_in_as(:member) do
    before do
      click_header_option("My Profile")
    end

    scenario 'With valid data' do
      fill_in("Given names", with: "Jordan")
      fill_in("Family name", with: "Maguire")
      fill_in("Email", with: "valid@example.com")
      fill_in("Current password", with: "password")
      click_button("Update")

      # User should be saved
      click_header_option("My Profile")
      current_user.reload
      expect(current_user.email).to eq("valid@example.com")
      expect(current_user.given_names).to eq("Jordan")
      expect(current_user.family_name).to eq("Maguire")
    end

    scenario 'With invalid data' do
      fill_in("Given names", with: "")
      fill_in("Family name", with: "")
      fill_in("Email", with: "")
      click_button("Update")

      expect(page).to have_error_message(:email, "can't be blank")
      expect(page).to have_error_message(:given_names, "can't be blank")
    end
  end
end
