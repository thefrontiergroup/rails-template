module Admin::UsersHelper

  def users_index_tab_for(label, path)
    classes = ""
    classes = "active" if request.path == path
    content_tag(:li, class: classes) { link_to(label, path) }
  end

end