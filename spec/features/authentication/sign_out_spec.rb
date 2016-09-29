require 'rails_helper'

feature 'Signed in users can sign out' do

  sign_in_as(:admin)

  scenario 'User signs out successfully' do
    click_sidemenu_option('Sign out')

    expect(current_path).to eq root_path
    expect(page).not_to have_flash :notice, /Signed out/
  end
end
