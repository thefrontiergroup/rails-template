shared_examples_for "unauthorized access to controller action" do

  it 'should redirect to the root page' do
    should redirect_to(AfterSignInPath.new(current_user).to_s)
  end

  it 'should display the unauthorized flash message' do
    subject
    expect(request.flash[:alert]).to include "You are not authorized to perform this action."
  end

end

shared_examples_for "action authorizes roles" do |authorized_roles|

  unauthorized_roles = User.roles.keys.map(&:to_sym) - authorized_roles
  unauthorized_roles.each do |role|
    authenticated_as(role) do
      it_behaves_like "unauthorized access to controller action"
    end
  end
end
