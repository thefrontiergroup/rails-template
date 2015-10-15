module FeatureAuthenticationMacros

  def signed_in_as(*roles, &specs)
    roles.each do |role_name|
      context "when signed in as #{role_name}" do
        sign_in_as(role_name)
        instance_eval(&specs)
      end
    end
  end

  def sign_in_as(type_or_user)
    before do
      sign_in_as(type_or_user)
    end

    let(:current_user) { @current_user }
  end

end
