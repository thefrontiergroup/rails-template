module ControllerParameterSupport

  # FactoryGirl.attributes_for ignores associations, which is problematic for us. So we make
  # our own implementation.
  def parameters_for(*factory_args)
    all_attributes = FactoryGirl.build(*factory_args).attributes
    all_attributes = all_attributes.reject {|attr_name| attr_name.to_s.in?(["id", "created_at", "updated_at", "deleted_at"]) }
    all_attributes
  end

end