module Feature
  module NavigationSupport

    def click_header_option(option)
      within(".large.menu") { click_link(option) }
    end

    def click_admin_my_profile_link(current_user)
      click_sidemenu_option(current_user.full_name)
    end

    def click_member_my_profile_link
      click_header_option("My Profile")
    end

    def click_sidemenu_option(option)
      within("div.left.fixed.vertical.menu") { click_link(option) }
    end

  end
end
