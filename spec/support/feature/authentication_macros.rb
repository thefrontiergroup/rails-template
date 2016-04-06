module Feature
  module AuthenticationMacros

    def signed_in_as(*roles, &specs)
      roles.each do |role_name|
        context "when signed in as #{role_name}" do
          sign_in_as(role_name)
          instance_eval(&specs)
        end
      end
    end

    # Use inside a feature, describe, or context block to create and sign a user in. EG:
    #
    # feature "an admin can acquire base" do
    #
    #   sign_in_as(:admin) # or
    #   sign_in_as(:admin, :with_ten_legs) # or
    #   sign_in_as(:admin, :with_ten_legs, {some_attribute: "has a value"})
    #
    #   scenario do
    #     current_user.some_attribute # "has a value"
    #   end
    # end
    #
    def sign_in_as(user_type, *traits_and_attributes)
      before do
        sign_in_as(user_type, *traits_and_attributes)
      end

      let(:current_user) { @current_user }
    end

  end
end
