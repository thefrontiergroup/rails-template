class UserPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if user.present? && (user.admin? || user.member?)
        scope
      else
        scope.none
      end
    end
  end

  def permitted_attributes
    if is_admin?
      [:email, :role, :password]
    elsif is_member?
      [:email, :password]
    else
      []
    end
  end

  def admin_dashboard?
    is_admin?
  end

  def member_dashboard?
    is_member?
  end

# CRUD

  alias :index_admins? :is_admin?
  def update?
    is_admin? || (user.present? && user == record)
  end
  alias :edit? :update?

end

