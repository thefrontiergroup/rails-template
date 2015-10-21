module Controller
  module ParameterSupport

    # FactoryGirl.attributes_for ignores associations, which is problematic for us. So we make
    # our own implementation.
    def parameters_for(*factory_args)
      sanitize_attributes(FactoryGirl.build(*factory_args))
    end

  private

    def sanitize_attributes(instance)
      attributes = sanitize_enums(instance, instance.attributes)
      attributes
        .reject {|attr_name| attr_name.in?(["id", "created_at", "updated_at", "deleted_at"]) }
        .with_indifferent_access
    end

    def sanitize_enums(instance, attributes)
      # Replaces enums integers with strings.
      # E.G:
      # instance = User.last
      # instance.attributes => { id: 1, status: 0 }
      # sanitize_attributes(instance) => { id: 1, status: 'active' }
      #
      instance.defined_enums.each do |enum, values|
        attributes[enum] = values.key(attributes[enum])
      end

      attributes
    end
  end
end