require 'rails_helper'

feature 'Admin can sort an index of users' do

  signed_in_as(:admin) do
    scenario "sorting by 'Email'" do
      alpha = FactoryGirl.create(:user, :member, email: "alpha@example.com")
      beta  = FactoryGirl.create(:user, :member, email: "beta@example.com")

      navigate_to_members_index

      click_link("Email")
      expect_objects_to_be_ordered(alpha, beta)

      click_link("Email")
      expect_objects_to_be_ordered(beta, alpha)
    end

    scenario "sorting by 'Given names'" do
      alpha = FactoryGirl.create(:user, :member, given_names: "alpha")
      beta  = FactoryGirl.create(:user, :member, given_names: "beta")

      navigate_to_members_index

      # Ordered by given_names by default
      expect_objects_to_be_ordered(alpha, beta)

      click_link("Given names")
      expect_objects_to_be_ordered(beta, alpha)

      click_link("Given names")
      expect_objects_to_be_ordered(alpha, beta)
    end

    scenario "sorting by 'Family name'" do
      alpha = FactoryGirl.create(:user, :member, family_name: "alpha")
      beta  = FactoryGirl.create(:user, :member, family_name: "beta")

      navigate_to_members_index

      click_link("Family name")
      expect_objects_to_be_ordered(alpha, beta)

      click_link("Family name")
      expect_objects_to_be_ordered(beta, alpha)
    end
  end

private

  def navigate_to_members_index
    click_header_option("Dashboard")
    click_sidemenu_option("Members")
  end

end
