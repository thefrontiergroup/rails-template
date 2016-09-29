module ApplicationHelper

  def current_page_title(object=nil)
    page_title!(t('.title', label: object))
  end

  def flash_class(level)
    case level.to_sym
    when :notice then "info message"
    when :success then "positive message"
    when :error then "error message"
    when :alert then "negative message"
    end
  end

end
