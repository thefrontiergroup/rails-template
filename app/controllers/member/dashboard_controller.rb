class Member::DashboardController < Member::BaseController

  def index
    authorize(User, :member_dashboard?)
  end

end