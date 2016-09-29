module FlashHelper

  def flash_class(level)
    case level.to_sym
    when :notice then "positive message"
    when :success then "positive message"
    when :error then "error message"
    when :alert then "negative message"
    end
  end

end
