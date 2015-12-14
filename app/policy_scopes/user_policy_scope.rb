class UserPolicyScope < ApplicationPolicyScope

  def resolve
    if user.present? && (user.admin? || user.member?)
      scope
    else
      scope.none
    end
  end

end
