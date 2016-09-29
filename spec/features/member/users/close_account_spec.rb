require 'rails_helper'

feature 'Member can close their account' do

  signed_in_as(:member) do
    before do
      click_member_my_profile_link
    end

    scenario do
      click_link("Close my account")

      expect(page).to have_flash(:notice, "Bye! Your account was successfully closed. We hope to see you again soon.")
      expect(current_path).to eq(root_path)
      expect(User.count).to eq(0)
    end

  end
end
