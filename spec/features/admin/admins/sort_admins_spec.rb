require 'rails_helper'

feature 'Admin can sort an index of users' do

  scenario "sorting by 'Email'" do
    alpha = FactoryGirl.create(:user, :admin, email: "alpha@example.com")
    beta  = FactoryGirl.create(:user, :admin, email: "beta@example.com")

    navigate_to_admins_index(alpha)

    expect_heading_to_sort_objects("Email", [alpha, beta])
  end

  scenario "sorting by 'Given names'" do
    alpha = FactoryGirl.create(:user, :admin, given_names: "alpha")
    beta  = FactoryGirl.create(:user, :admin, given_names: "beta")

    navigate_to_admins_index(alpha)

    # Ordered by given_names by default
    expect_heading_to_sort_objects("Given names", [alpha, beta], sorted_by_default: true)
  end

  scenario "sorting by 'Family name'" do
    alpha = FactoryGirl.create(:user, :admin, family_name: "alpha")
    beta  = FactoryGirl.create(:user, :admin, family_name: "beta")

    navigate_to_admins_index(alpha)

    expect_heading_to_sort_objects("Family name", [alpha, beta])
  end

private

  def navigate_to_admins_index(user)
    sign_in_as(user)
    click_sidemenu_option("Dashboard")
    click_sidemenu_option("Admins")
  end

end
