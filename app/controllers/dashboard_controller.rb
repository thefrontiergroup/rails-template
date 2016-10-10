class DashboardController < AuthenticatedController

  def index
    authorize!(:show, :user_dashboard)
  end

end
