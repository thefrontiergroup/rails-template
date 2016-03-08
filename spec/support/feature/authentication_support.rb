module Feature
  module AuthenticationSupport

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
      if user.admin?
        admin_dashboard_index_path
      elsif user.member?
        member_dashboard_index_path
      else
        root_path
      end
    end

  end
end
