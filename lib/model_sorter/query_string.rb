class ModelSorter::QueryString

  # Returns a params string "a=b&c=d" for sortable params for a given attribute.
  #
  # Uses params to take into account what is already being sorted so that it can alternate
  # between no sorting, descending, and ascending (in that order).
  #
  # attribute: string or symbol of an attribute name to inject into the query string and to
  #            look for in the provided params
  # params: A HashWithIndifferentAccess, the params provided by the controller.
  #
  def hash_with_cycled_sorting_params(attribute, params)
    existing_sortable_direction = get_existing_sortable_direction_for(attribute, params.with_indifferent_access)
    sort_params(attribute, cycle_sortable_direction(existing_sortable_direction))
  end

private

  def cycle_sortable_direction(sort_direction)
    case sort_direction
    when nil
      "asc"
    when "asc"
      "desc"
    when "desc"
      nil
    end
  end

  def get_existing_sortable_direction_for(attribute, params)
    if params[:sort_attribute].blank? || params[:sort_direction].blank?
      nil
    else
      # If the params are already sorted by the given attribute, we should return the current
      # sort_direction so that we can cycle through them.
      if params[:sort_attribute].to_s == attribute.to_s
        params[:sort_direction]
      # Otherwise we need to start from the first position
      else
        nil
      end
    end
  end

  def sort_params(sort_attribute, sort_direction)
    if sort_direction.present?
      {sort_attribute: sort_attribute, sort_direction: sort_direction}
    else
      {}
    end
  end

end