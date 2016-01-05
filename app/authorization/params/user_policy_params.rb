class UserPolicyParams < ApplicationPolicyParams

  def permitted_attributes
    if is_admin?
      [:email, :password, :role]
    elsif is_member?
      [:email, :password]
    else
      []
    end
  end

end
