module ApplicationHelper

  def current_page_title(object=nil)
    page_title!(t('.title', label: object))
  end

end
