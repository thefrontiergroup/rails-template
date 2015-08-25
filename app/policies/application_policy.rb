class ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end
  end

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

  def index?
    can_crud?
  end

  def new?
    can_crud?
  end

  def create?
    can_crud?
  end

  def edit?
    can_crud?
  end

  def update?
    can_crud?
  end

  def destroy?
    can_crud?
  end

protected

  def can_crud?
    is_admin?
  end

end