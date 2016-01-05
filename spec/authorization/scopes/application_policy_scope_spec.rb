require 'rails_helper'

RSpec.describe ApplicationPolicyScope do
  let(:policy_scope) { ApplicationPolicyScope.new(user, scope) }
  let(:user)  { User.new }
  let(:scope) { User.all }

  describe "#initialize" do
    subject { policy_scope }

    it "sets the user" do
      expect(subject.user).to eq(user)
    end

    it "sets the scope" do
      expect(subject.scope).to eq(scope)
    end
  end
end
