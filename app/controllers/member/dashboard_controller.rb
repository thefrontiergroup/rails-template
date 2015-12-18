class Member::DashboardController < Member::BaseController

  def index
    authorize(:dashboard, :member_dashboard?)
  end

end
