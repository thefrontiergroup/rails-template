class Admin::DashboardController < Admin::BaseController

  def index
    authorize!(:show, :admin_dashboard)
    @user_count = User.count
  end

end
