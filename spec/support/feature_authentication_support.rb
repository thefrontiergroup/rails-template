module FeatureAuthenticationSupport

  def sign_in_as(role_or_user = :public_user)
    if role_or_user.is_a?(User)
      @current_user = role_or_user
    else
      @current_user = FactoryGirl.create :user, role_or_user
    end

    login_as(@current_user, scope: :user)
    visit get_dashboard_path(@current_user)
  end

  def get_dashboard_path(user)
    user_policy = UserPolicy.new(user, user)
    if user_policy.admin_dashboard?
      admin_dashboard_index_path
    elsif user_policy.member_dashboard?
      member_dashboard_index_path
    else
      root_path
    end
  end
end
