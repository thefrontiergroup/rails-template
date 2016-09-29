require 'rails_helper'

feature 'Admin can search for members by email' do

  signed_in_as(:admin) do
    let!(:matching_member) do
      FactoryGirl.create(:user, :member, {
        given_names: "Bob",
        family_name: "Dobolina",
        email: "something_innocuous@example.com"
      })
    end
    let!(:other_member) do
      FactoryGirl.create(:user, :member, {
        given_names: "Ralphy",
        family_name: "Wiggum",
        email: "another_thing@example.com"
      })
    end

    before do
      click_sidemenu_option("Dashboard")
      click_sidemenu_option("Members")
    end

    scenario "Search by email" do
      expect(page).to have_content(matching_member.email)
      expect(page).to have_content(other_member.email)

      fill_in('Search by name or email', with: matching_member.email)
      click_button('Search')

      expect(page).to have_content(matching_member.email)
      expect(page).not_to have_content(other_member.email)

      fill_in('Search by name or email', with: "Not a valid email for this individual")
      click_button('Search')

      expect(page).to have_content("No users matched your search")
      expect(page).not_to have_content(matching_member.email)
      expect(page).not_to have_content(other_member.email)
    end

    scenario "Search by name" do
      expect(page).to have_content(matching_member.given_names)
      expect(page).to have_content(other_member.given_names)

      # Only given_names
      fill_in('Search by name or email', with: "Bob")
      click_button('Search')

      expect(page).to have_content(matching_member.given_names)
      expect(page).not_to have_content(other_member.given_names)

      # Only family_name
      fill_in('Search by name or email', with: "Dob")
      click_button('Search')

      expect(page).to have_content(matching_member.given_names)
      expect(page).not_to have_content(other_member.given_names)

      # Full name
      fill_in('Search by name or email', with: "Bob Dob")
      click_button('Search')

      expect(page).to have_content(matching_member.given_names)
      expect(page).not_to have_content(other_member.given_names)
    end
  end

end
