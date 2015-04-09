module FeatureAuthenticationMacros

  def sign_in_as(type_or_user)
    before do
      sign_in_as(type_or_user)
    end

    let(:current_user) { @current_user }
  end

end
