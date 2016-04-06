module Controller
  module AuthenticationSupport
    def authenticated_as(role_or_user, &block)
      context "when user is signed in" do
        let(:current_user) do
          # Check if the value passed through is the name of a variable defined in the spec
          if respond_to?(role_or_user)
            send(role_or_user)
          # Otherwise assume it is the name of a role, and return that
          else
            FactoryGirl.create(:user, role_or_user)
          end
        end

        before { sign_in(current_user) }

        instance_eval &block
      end
    end
  end
end
