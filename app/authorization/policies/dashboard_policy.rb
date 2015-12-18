class DashboardPolicy < ApplicationPolicy

  def admin_dashboard?
    is_admin?
  end

  def member_dashboard?
    is_member?
  end

end

