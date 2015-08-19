class ModelSorter::UriConstructor

  # Return a URI object representing the full URI with the existing query string plus
  # sorting parameters. If there are already sorting parameters we will either cycle them
  # (EG: changing asc to desc, or desc to nil), or overwrite them (EG: we are changing
  # the attribute that is being sorted).
  #
  # So if the original query string has ?sort_direction=asc we would return ?sort_direction=desc.
  #
  # Given the arguments:
  #   attribute: "dongle"
  #   path: "www.google.com"
  #   query_params: {"jordan" => "rules"}
  #
  # We would return URI: www.google.com?jordan=rules&sort_attribute=dongle&sort_direction=asc
  #
  def build_uri_with_cycled_sorting_params(attribute, path, query_params)
    uri = URI(path)
    sortable_query_params = ModelSorter::QueryString.new.hash_with_cycled_sorting_params(attribute, query_params)
    # Clone the parameters so that we do not change the actual page parameters
    full_params = query_params.clone
    # Remove any sorting options from the parameters so that we can replace them with nil if required.
    full_params.delete_if {|key, value| key == "sort_direction" || key == "sort_attribute"}
    uri.query = full_params.merge(sortable_query_params).to_query
    uri
  end

end