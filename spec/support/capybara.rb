module Capybara
  class Session
    def has_flash?(flash_type, value=nil)
      case flash_type
      when :alert
        css_class = "negative"
      when :notice
        css_class = "positive"
      else
        raise(ArgumentError, "Unhandled flash type #{css_class}")
      end

      has_css?("div.message.#{css_class}", text: value)
    end

    def has_error_message?(field, message)
      has_css?("[class*='#{field}'].error", text: message)
    end
  end
end
