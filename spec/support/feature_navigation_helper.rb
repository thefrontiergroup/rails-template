module FeatureNavigationHelper

  def click_header_option(option)
    within("nav") do
      click_link(option)
    end
  end

  def click_sidemenu_option(option)
    within(".sidebar") do
      click_link(option)
    end
  end

end