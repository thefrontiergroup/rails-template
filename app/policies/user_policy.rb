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

  alias :index? :is_admin?
  alias :new? :is_admin?
  alias :create? :is_admin?
  alias :destroy? :is_admin?

  def update?
    is_admin? || (user.present? && user == record)
  end
  alias :edit? :update?

end

