module AuthenticationSupport
  def authenticated_as(role, &block)
    context "when user is signed in" do
      let(:current_user) { FactoryGirl.create(:user, role) }

      before { sign_in(current_user) }

      instance_eval &block
    end
  end
end