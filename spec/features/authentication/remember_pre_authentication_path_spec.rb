require 'rails_helper'

feature "user should be redirected to same path they tried to access when unauthenticated" do

  let(:user) { FactoryGirl.create(:user, :admin) }

  scenario do
    visit(admin_admins_path)

    expect(page).to have_flash(:alert, "You need to sign in or sign up before continuing.")
    expect(current_path).not_to eq(admin_admins_path)

    fill_in("Email", with: user.email)
    fill_in("Password", with: "password")
    click_button("Sign in")

    expect(current_path).to eq(admin_admins_path)
  end

end
