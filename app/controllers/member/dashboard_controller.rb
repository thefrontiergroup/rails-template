class Member::DashboardController < Member::BaseController

  def index
    authorize(current_user, :member_dashboard?)
  end

end