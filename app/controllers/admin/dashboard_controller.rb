class Admin::DashboardController < Admin::BaseController

  def index
    authorize!(:show, :admin_dashboard)
  end

end
