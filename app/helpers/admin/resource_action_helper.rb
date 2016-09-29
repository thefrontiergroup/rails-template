module Admin::ResourceActionHelper

  def link_to_archive_resource(path, resource_name, html_options={})
    html_options = html_options.reverse_merge({
      class: "ui icon tiny compact negative button",
      data: {confirm: t("actions.archive_prompt.confirmation", name: resource_name)},
      method: :delete,
    })

    link_to(path, html_options) do
      [
        content_tag("i", nil, {class: "archive icon"}),
        t("actions.archive_prompt.label")
      ].join.html_safe
    end
  end

end
