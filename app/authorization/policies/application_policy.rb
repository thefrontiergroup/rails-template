class ApplicationPolicy

  include PolicySupport

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

  def show?
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

  # Override this method if you want to change the default authorization rules for the CRUD actions
  def can_crud?
    is_admin?
  end

end
