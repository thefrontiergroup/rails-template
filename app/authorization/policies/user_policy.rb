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

# CRUD

  # Admins can't delete themselves.
  def destroy?
    is_admin? && user != record
  end

  alias :index_admins? :is_admin?
  def update?
    is_admin? || (user.present? && user == record)
  end
  alias :edit? :update?

end

