require 'spec_helper'

describe UserPolicy do
  subject { UserPolicy.new(user, user) }

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
    it { should_not permit_access_to(:update) }
    it { should_not permit_access_to(:destroy) }
  end
end