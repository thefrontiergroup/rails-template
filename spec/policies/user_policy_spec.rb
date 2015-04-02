require 'spec_helper'

describe UserPolicy do
  subject { UserPolicy.new(user, target_user) }
  let(:target_user) { user }

  context "for an anonymous user" do
    let(:user) { nil }

    it { should_not permit_access_to(:admin_dashboard) }
    it { should_not permit_access_to(:member_dashboard) }

    # CRUD actions
    it { should_not permit_access_to(:index) }
    it { should_not permit_access_to(:create) }
    it { should_not permit_access_to(:update) }
    it { should_not permit_access_to(:destroy) }
  end

  context "for an admin" do
    let(:user) { FactoryGirl.build(:user, :admin) }

    it { should permit_access_to(:admin_dashboard) }
    it { should permit_access_to(:member_dashboard) }

    # CRUD actions
    it { should permit_access_to(:index) }
    it { should permit_access_to(:create) }
    it { should permit_access_to(:update) }
    it { should permit_access_to(:destroy) }
  end

  context "for a member" do
    let(:user) { FactoryGirl.build(:user, :member) }

    it { should_not permit_access_to(:admin_dashboard) }
    it { should     permit_access_to(:member_dashboard) }

    # CRUD actions
    it { should_not permit_access_to(:index) }
    it { should_not permit_access_to(:create) }
    describe "update?" do
      context "when user is current user" do
        let(:target_user) { user }
        it { should permit_access_to(:update) }
      end
      context "when user is other user" do
        let(:target_user) { FactoryGirl.build(:user) }
        it { should_not permit_access_to(:update) }
      end
    end
    it { should_not permit_access_to(:destroy) }
  end
end