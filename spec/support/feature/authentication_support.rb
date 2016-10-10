module Feature
  module AuthenticationSupport

    # Use inside a feature spec to sign a user in.
    #
    # scenario "do a thing" do
    #   sign_in_as(:admin) # or
    #   sign_in_as(:admin, :with_ten_legs) # or
    #   sign_in_as(:admin, :with_ten_legs, {some_attribute: "has a value"})
    #
    def sign_in_as(role_or_user, *traits_and_attributes)
      if role_or_user.is_a?(User)
        @current_user = role_or_user
      else
        @current_user = FactoryGirl.create :user, role_or_user, *traits_and_attributes
      end

      login_as(@current_user, scope: :user)
      visit get_dashboard_path(@current_user)
    end

  private

    def get_dashboard_path(user)
      if user.admin?
        admin_dashboard_index_path
      elsif user.member?
        dashboard_path
      else
        root_path
      end
    end

  end
end
