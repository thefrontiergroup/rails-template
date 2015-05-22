module ApplicationHelper

  def sortable_heading_for(attribute)
    sort_direction = request.query_parameters[:sort_direction]
    sortable_uri = ModelSorter::UriConstructor.new.build_uri_with_cycled_sorting_params(attribute, request.path, request.query_parameters)
    link_to(attribute.to_s.titleize, sortable_uri.to_s, class: "sortable #{sort_direction}")
  end

end
