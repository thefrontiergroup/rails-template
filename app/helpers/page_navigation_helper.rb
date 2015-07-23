module PageNavigationHelper

  def page_navigation_link_to(title, path)
    args = {}
    # This requires that an index path is passed through to work. If path is: /admin/users/
    # then the following paths will return active:
    #   * /admin/users/new
    #   * /admin/users/1
    #   * /admin/users/1/edit
    #
    args = {class: "active"} if request.url.include?(path)
    content_tag(:li, args) do
      link_to(title, path)
    end
  end

end