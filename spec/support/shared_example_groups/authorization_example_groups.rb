shared_examples_for "unauthorized access to controller action" do

  it 'should redirect to the root page' do
    should redirect_to(root_path)
  end

  it 'should display the unauthorized flash message' do
    subject
    expect(request.flash[:alert]).to include "You are not authorized to perform this action."
  end

end