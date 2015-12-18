require 'rails_helper'

RSpec.describe DashboardPolicy do
  subject { policy }
  let(:policy) { DashboardPolicy.new(user, target_user) }
  let(:target_user) { user }

  context "for an anonymous user" do
    let(:user) { nil }

    it { should_not permit_access_to(:admin_dashboard) }
    it { should_not permit_access_to(:member_dashboard) }
  end

  context "for an admin" do
    let(:user) { FactoryGirl.build(:user, :admin) }

    it { should permit_access_to(:admin_dashboard) }
    it { should_not permit_access_to(:member_dashboard) }
  end

  context "for a member" do
    let(:user) { FactoryGirl.build(:user, :member) }

    it { should_not permit_access_to(:admin_dashboard) }
    it { should     permit_access_to(:member_dashboard) }
  end
end
