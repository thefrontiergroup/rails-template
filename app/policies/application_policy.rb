class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def is_admin?
    user.present? && user.admin?
  end

  def is_member?
    user.present? && user.member?
  end

# CRUD

  alias :index?   :is_admin?
  alias :new?     :is_admin?
  alias :create?  :is_admin?
  alias :edit?    :is_admin?
  alias :update?  :is_admin?
  alias :destroy? :is_admin?

end