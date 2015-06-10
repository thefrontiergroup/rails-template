require 'rails_helper'

feature 'Signed in users can sign out' do

  sign_in_as(:admin)

  scenario 'User signs out successfully' do
    click_link 'Sign out'

    expect(current_path).to eq root_path
    expect(page).to have_flash :notice, /Signed out/
  end
end
