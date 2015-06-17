module FeatureAttributesSupport

  def fill_in_form(prefix, attributes)
    attributes.each do |attribute, value|
      field_name = prefix + "_" + attribute.to_s
      case value
      when true
        check(field_name)
      when false
        uncheck(field_name)
      else
        field = find_field(field_name)
        case field.tag_name
        when "select"
          field.select value
        else
          field.set value
        end
      end
    end
  end

end