class Admin::DashboardController < Admin::BaseController

  def index
    authorize(User, :admin_dashboard?)
  end

end