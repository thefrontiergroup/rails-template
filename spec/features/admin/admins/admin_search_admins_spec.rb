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
    click_header_option("Dashboard")
    click_sidemenu_option("Admins")
  end

  scenario "Search with email" do
    expect(page).to have_content(matching_admin.email)
    expect(page).to have_content(current_user.email)

    fill_in('Search by given names, family name, or email', with: matching_admin.email)
    click_button('Search')

    expect(page).to have_content(matching_admin.email)
    expect(page).not_to have_content(current_user.email)

    fill_in('Search by given names, family name, or email', with: "Not a valid email for this individual")
    click_button('Search')

    expect(page).to have_content("No users matched your search")
    expect(page).not_to have_content(matching_admin.email)
    expect(page).not_to have_content(current_user.email)
  end

  scenario "Search with given_names" do
    expect(page).to have_content(matching_admin.given_names)
    expect(page).to have_content(current_user.given_names)

    fill_in('Search by given names, family name, or email', with: matching_admin.given_names)
    click_button('Search')

    expect(page).to have_content(matching_admin.given_names)
    expect(page).not_to have_content(current_user.given_names)

    fill_in('Search by given names, family name, or email', with: "Not a valid given name for this individual")
    click_button('Search')

    expect(page).to have_content("No users matched your search")
    expect(page).not_to have_content(matching_admin.given_names)
    expect(page).not_to have_content(current_user.given_names)
  end

  scenario "Search with family_name" do
    expect(page).to have_content(matching_admin.family_name)
    expect(page).to have_content(current_user.family_name)

    fill_in('Search by given names, family name, or email', with: matching_admin.family_name)
    click_button('Search')

    expect(page).to have_content(matching_admin.family_name)
    expect(page).not_to have_content(current_user.family_name)

    fill_in('Search by given names, family name, or email', with: "Not a valid family name for this individual")
    click_button('Search')

    expect(page).to have_content("No users matched your search")
    expect(page).not_to have_content(matching_admin.family_name)
    expect(page).not_to have_content(current_user.family_name)
  end

end
