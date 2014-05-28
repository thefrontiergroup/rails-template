module Capybara
  class Session
    def has_flash?(name, value=nil)
      has_css?(".flash.flash-#{name}", text: value)
    end
  end
end
