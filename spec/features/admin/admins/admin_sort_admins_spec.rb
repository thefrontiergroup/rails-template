require 'rails_helper'

feature 'Admin can sort an index of users' do

  let!(:alpha_admin) { FactoryGirl.create(:user, :admin, email: "alpha@example.com") }
  let!(:beta_admin)  { FactoryGirl.create(:user, :admin, email: "beta@example.com") }

  before do
    sign_in_as(alpha_admin)
    click_header_option("Dashboard")
    click_sidemenu_option("Admins")
  end

  scenario "Using tabs to show different types of users" do
    # Order by Ascending first
    click_link("Email")

    expect_users_to_be_ordered_as(alpha_admin, beta_admin)

    # Order by Descending next
    click_link("Email")
    expect_users_to_be_ordered_as(beta_admin, alpha_admin)
  end

private

  def expect_users_to_be_ordered_as(first, second)
    within(first_row) { expect(page).to have_content(first.email) }
    within(second_row) { expect(page).to have_content(second.email) }
  end

end