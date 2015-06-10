require 'rails_helper'

feature 'Admin can view an index of users' do

  sign_in_as(:admin)
  let!(:member) { FactoryGirl.create(:user, :member) }

  before do
    click_header_option("Dashboard")
    click_sidemenu_option("Users")
  end

  scenario "Using tabs to show different types of users" do
    # By default, show only members
    within("table") do
      expect(page).to have_content(member.email)
      expect(page).not_to have_content(current_user.email)
    end

    click_link("Admins")
    within("table") do
      expect(page).not_to have_content(member.email)
      expect(page).to have_content(current_user.email)
    end
  end

end