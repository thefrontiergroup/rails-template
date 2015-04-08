class UserPolicy < ApplicationPolicy

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

  def index?
    is_admin?
  end

  def create?
    is_admin?
  end

  def update?
    is_admin? || (user.present? && user == record)
  end

  def destroy?
    is_admin?
  end

end

