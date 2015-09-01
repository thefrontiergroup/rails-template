module ControllerParameterSupport

  # FactoryGirl.attributes_for ignores associations, which is problematic for us. So we make
  # our own implementation.
  def parameters_for(*factory_args)
    all_attributes = sanitize_attributes(FactoryGirl.build(*factory_args))
    all_attributes = all_attributes.reject {|attr_name| attr_name.in?(["id", "created_at", "updated_at", "deleted_at"]) }
    all_attributes
  end

private

  def sanitize_attributes(instance)
    attributes = instance.attributes

    # Replaces enums integers with strings.
    # E.G:
    # instance = User.last
    # instance.attributes => { id: 1, status: 0 }
    # sanitize_attributes(instance) => { id: 1, status: 'active' }
    #
    instance.defined_enums.each do |enum, values|
      attributes[enum] = values.key(attributes[enum])
    end

    attributes.with_indifferent_access
  end
end