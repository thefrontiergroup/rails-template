module ApplicationHelper

  def current_page_title(object=nil)
    if can?(:manage, :all)
      title_type = :admin
    else
      title_type = :default
    end

    page_title!(t('.title', label: object), title_type)
  end

end
