require 'rails_helper'

RSpec.describe UserPolicyParams do
  subject { policy.permitted_attributes }
  let(:policy) { UserPolicyParams.new(user, target_user) }
  let(:target_user) { user }

  context "for an anonymous user" do
    let(:user) { nil }
    it { should be_empty }
  end

  context "for an admin" do
    let(:user) { FactoryGirl.build(:user, :admin) }

    it { should include(:email) }
    it { should include(:password) }
    it { should include(:role) }
  end

  context "for a member" do
    let(:user) { FactoryGirl.build(:user, :member) }

    it { should     include(:email) }
    it { should     include(:password) }
    it { should_not include(:role) }
  end
end
