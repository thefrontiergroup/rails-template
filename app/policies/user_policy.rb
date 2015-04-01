class UserPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def admin_dashboard?
    user.present? && user.admin?
  end

  def member_dashboard?
    user.present?
  end
end

