class Admin::DashboardController < Admin::BaseController

  def index
    authorize(current_user, :admin_dashboard?)
  end

end