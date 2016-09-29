require 'rails_helper'

feature 'Admin can sort an index of users' do

  signed_in_as(:admin) do
    scenario "sorting by 'Email'" do
      alpha = FactoryGirl.create(:user, :member, email: "alpha@example.com")
      beta  = FactoryGirl.create(:user, :member, email: "beta@example.com")

      navigate_to_members_index

      expect_heading_to_sort_objects("Email", [alpha, beta])
    end

    scenario "sorting by 'Given names'" do
      alpha = FactoryGirl.create(:user, :member, given_names: "alpha")
      beta  = FactoryGirl.create(:user, :member, given_names: "beta")

      navigate_to_members_index

      # Ordered by given_names by default
      expect_heading_to_sort_objects("Given names", [alpha, beta], sorted_by_default: true)
    end

    scenario "sorting by 'Family name'" do
      alpha = FactoryGirl.create(:user, :member, family_name: "alpha")
      beta  = FactoryGirl.create(:user, :member, family_name: "beta")

      navigate_to_members_index

      expect_heading_to_sort_objects("Family name", [alpha, beta])
    end
  end

private

  def navigate_to_members_index
    click_sidemenu_option("Dashboard")
    click_sidemenu_option("Members")
  end

end
