module FeatureMacros

  def sign_in
    before do
      sign_in
    end

    let(:current_user) { @current_user }
  end

end