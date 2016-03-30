require 'rails_helper'

feature 'Admin can sort an index of users' do

  signed_in_as(:admin) do
    let!(:alpha_member) { FactoryGirl.create(:user, :member, email: "alpha@example.com") }
    let!(:beta_member)  { FactoryGirl.create(:user, :member, email: "beta@example.com") }

    before do
      click_header_option("Dashboard")
      click_sidemenu_option("Members")
    end

    scenario do
      # Order by Ascending by default
      expect_users_to_be_ordered_as(alpha_member, beta_member)

      # Order by Descending next
      click_link("Email")
      expect_users_to_be_ordered_as(beta_member, alpha_member)

      # Back to Ascending
      click_link("Email")
      expect_users_to_be_ordered_as(alpha_member, beta_member)
    end
  end

private

  def expect_users_to_be_ordered_as(first, second)
    within(first_row) { expect(page).to have_content(first.email) }
    within(second_row) { expect(page).to have_content(second.email) }
  end

end
