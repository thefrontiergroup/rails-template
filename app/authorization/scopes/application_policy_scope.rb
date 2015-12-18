class ApplicationPolicyScope

  attr_reader :user, :scope

  def initialize(user, scope)
    @user = user
    @scope = scope
  end

end
