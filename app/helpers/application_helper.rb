module ApplicationHelper

  def sortable_heading_for(attribute)
    existing_sort_direction = existing_sort_direction_for_attribute(attribute, request.query_parameters)
    sortable_uri = ModelSorter::UriConstructor.new.build_uri_with_cycled_sorting_params(attribute, request.path, request.query_parameters)

    link_to(attribute.to_s.titleize, sortable_uri.to_s, class: "sortable #{existing_sort_direction}")
  end

private

  def existing_sort_direction_for_attribute(attribute, query_parameters)
    if query_parameters[:sort_attribute].to_s == attribute.to_s
      request.query_parameters[:sort_direction]
    end
  end

end
