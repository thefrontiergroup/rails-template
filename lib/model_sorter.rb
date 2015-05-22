class ModelSorter

  def self.sort(scope, params)
    sort_attribute = params[:sort_attribute]
    sort_direction = params[:sort_direction]

    if sort_attribute.present? && sort_direction.present?
      sort_scope(scope, sort_attribute, sort_direction)
    else
      scope
    end
  end

private

  def self.sort_scope(scope, attribute, direction)
    case direction
    when "asc", "desc"
      scope.order("#{attribute} #{direction}")
    else
      raise(ArgumentError, "Unknown sort direction provided: #{direction}")
    end
  end

end