class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def admin_dashboard?
    is_admin?
  end

  def member_dashboard?
    user.present?
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

private

  def is_admin?
    user.present? && user.admin?
  end
end

