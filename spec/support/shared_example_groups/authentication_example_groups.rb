shared_examples_for "action requiring authentication" do

  before { subject }

  it 'should redirect to the sign in page' do
    expect(response).to redirect_to(new_user_session_url)
  end

  it 'should display the unauthorized flash message' do
    expect(request.flash[:alert]).to include("You need to sign in or sign up before continuing.")
  end

end