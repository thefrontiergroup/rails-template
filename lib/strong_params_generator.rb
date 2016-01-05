class StrongParamsGenerator

  attr_reader :klass_or_instance, :user

  def initialize(user, klass_or_instance)
    @user     = user
    @klass_or_instance = klass_or_instance
  end

  def permitted_attributes
    params_policy_class(klass_or_instance).new(user, klass_or_instance).permitted_attributes
  end

private

  # User => "User"
  # User.new => "User"
  def resource_as_constant_name
    if klass_or_instance.is_a?(Class)
      klass_or_instance.name
    else
      klass_or_instance.class.name
    end
  end

  # EG: UserPolicyParams
  def params_policy_class(klass_or_instance)
    "#{resource_as_constant_name}Params".constantize
  end

end
