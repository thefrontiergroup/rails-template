module Admin::ResourceActionHelper

  def link_to_archive_resource(path, resource_name, html_options={})
    html_options = html_options.reverse_merge({
      class: "btn btn-small btn-danger",
      data: {confirm: t("actions.archive_prompt.confirmation", name: resource_name)},
      method: :delete,
    })

    link_to(t("actions.archive_prompt.label"), path, html_options)
  end

end
