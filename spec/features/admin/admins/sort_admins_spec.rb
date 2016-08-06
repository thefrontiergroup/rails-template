require 'rails_helper'

feature 'Admin can sort an index of users' do

  scenario "sorting by 'Email'" do
    alpha_admin = FactoryGirl.create(:user, :admin, email: "alpha@example.com")
    beta_admin  = FactoryGirl.create(:user, :admin, email: "beta@example.com")

    navigate_to_admins_index(alpha_admin)

    click_link("Email")
    expect_objects_to_be_ordered(alpha_admin, beta_admin)

    click_link("Email")
    expect_objects_to_be_ordered(beta_admin, alpha_admin)
  end

  scenario "sorting by 'Given names'" do
    alpha_admin = FactoryGirl.create(:user, :admin, given_names: "alpha")
    beta_admin  = FactoryGirl.create(:user, :admin, given_names: "beta")

    navigate_to_admins_index(alpha_admin)

    # Ordered by given_names by default
    expect_objects_to_be_ordered(alpha_admin, beta_admin)

    click_link("Given names")
    expect_objects_to_be_ordered(beta_admin, alpha_admin)

    click_link("Given names")
    expect_objects_to_be_ordered(alpha_admin, beta_admin)
  end

  scenario "sorting by 'Family name'" do
    alpha_admin = FactoryGirl.create(:user, :admin, family_name: "alpha")
    beta_admin  = FactoryGirl.create(:user, :admin, family_name: "beta")

    navigate_to_admins_index(alpha_admin)

    click_link("Family name")
    expect_objects_to_be_ordered(alpha_admin, beta_admin)

    click_link("Family name")
    expect_objects_to_be_ordered(beta_admin, alpha_admin)
  end

private

  def navigate_to_admins_index(user)
    sign_in_as(user)
    click_header_option("Dashboard")
    click_sidemenu_option("Admins")
  end

end
