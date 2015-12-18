require 'rails_helper'

describe UserPolicyScope do
  let(:policy_scope) { UserPolicyScope.new(user, scope) }
  let(:scope) { User.all }

  describe "#resolve" do
    subject { policy_scope.resolve }

    context "for an anonymous user" do
      let(:user) { nil }

      it "cannot see any users" do
        should be_empty
      end
    end

    context "for an admin" do
      let(:user) { FactoryGirl.build(:user, :admin) }

      it { should include(FactoryGirl.create(:user, :admin)) }
      it { should include(FactoryGirl.create(:user, :member)) }
    end

    context "for a member" do
      let(:user) { FactoryGirl.build(:user, :member) }

      it { should include(FactoryGirl.create(:user, :admin)) }
      it { should include(FactoryGirl.create(:user, :member)) }
    end
  end
end
