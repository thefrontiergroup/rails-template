module ControllerParameterSupport

  # FactoryGirl.attributes_for ignores associations, which is problematic for us. So we make
  # our own implementation.
  def parameters_for(*factory_args)
    all_attributes = FactoryGirl.build(*factory_args).attributes.with_indifferent_access
    all_attributes = all_attributes.reject {|attr_name| attr_name.in?(["id", "created_at", "updated_at", "deleted_at"]) }
    all_attributes
  end

end