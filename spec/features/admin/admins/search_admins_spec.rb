require 'rails_helper'

feature 'Admin can search for admins by email' do

  let!(:current_user) do
    FactoryGirl.create(:user, :admin, {
      given_names: "Ralphy",
      family_name: "Wiggum",
      email: "another_thing@example.com"
    })
  end
  let!(:matching_admin) do
    FactoryGirl.create(:user, :admin, {
      given_names: "Bob",
      family_name: "Dobolina",
      email: "something_innocuous@example.com"
    })
  end

  before do
    sign_in_as(current_user)
    click_sidemenu_option("Dashboard")
    click_sidemenu_option("Admins")
  end

  scenario "Search by email" do
    within("table") do
      expect(page).to have_content(matching_admin.email)
      expect(page).to have_content(current_user.email)
    end

    fill_in('Search by name or email', with: matching_admin.email)
    click_button('Search')

    within("table") do
      expect(page).to have_content(matching_admin.email)
      expect(page).not_to have_content(current_user.email)
    end

    fill_in('Search by name or email', with: "Not a valid email for this individual")
    click_button('Search')

    expect(page).to have_content("No users matched your search")
    expect(page).not_to have_content(matching_admin.email)
    expect(page).not_to have_content(current_user.email)
  end

  scenario "Search by name" do
    within("table") do
      expect(page).to have_content(matching_admin.given_names)
      expect(page).to have_content(current_user.given_names)
    end

    # Only given_names
    fill_in('Search by name or email', with: "Bob")
    click_button('Search')

    within("table") do
      expect(page).to have_content(matching_admin.given_names)
      expect(page).not_to have_content(current_user.given_names)
    end

    # Only family_name
    fill_in('Search by name or email', with: "Dob")
    click_button('Search')

    within("table") do
      expect(page).to have_content(matching_admin.given_names)
      expect(page).not_to have_content(current_user.given_names)
    end

    # Full name
    fill_in('Search by name or email', with: "Bob Dob")
    click_button('Search')

    within("table") do
      expect(page).to have_content(matching_admin.given_names)
      expect(page).not_to have_content(current_user.given_names)
    end
  end

end
