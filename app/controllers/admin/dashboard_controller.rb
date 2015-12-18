class Admin::DashboardController < Admin::BaseController

  def index
    authorize(:dashboard, :admin_dashboard?)
  end

end
