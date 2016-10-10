class AfterSignInPath

  include Rails.application.routes.url_helpers

  attr_reader :user

  def initialize(user)
    @user = user
  end

  def to_s
    if user.present?
      if user.admin?
        admin_dashboard_index_path
      else
        dashboard_path
      end
    else
      root_path
    end
  end

end
