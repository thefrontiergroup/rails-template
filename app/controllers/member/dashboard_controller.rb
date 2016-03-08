class Member::DashboardController < Member::BaseController

  def index
    authorize!(:show, :member_dashboard)
  end

end
