require 'spec_helper'

feature 'Signed in users can sign out' do

  sign_in

  scenario 'User signs out successfully' do
    click_link 'Sign out'

    current_path.should eq root_path
    expect(page).to have_flash :notice, /Signed out/
  end
end
