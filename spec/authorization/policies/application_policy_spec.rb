require 'rails_helper'

RSpec.describe ApplicationPolicy do
  subject { policy }
  let(:policy) { ApplicationPolicy.new(user, unused_object) }
  #target object is not used in the policy, however pundit requires two objects to be passed in
  let(:unused_object) { "unused object" }

  context "for an anonymous user" do
    let(:user) { nil }

    # CRUD actions
    it { should_not permit_access_to(:index) }
    it { should_not permit_access_to(:new) }
    it { should_not permit_access_to(:create) }
    it { should_not permit_access_to(:edit) }
    it { should_not permit_access_to(:update) }
    it { should_not permit_access_to(:destroy) }
  end

  context "for an admin" do
    let(:user) { FactoryGirl.build(:user, :admin) }

    # CRUD actions
    it { should permit_access_to(:index) }
    it { should permit_access_to(:new) }
    it { should permit_access_to(:create) }
    it { should permit_access_to(:edit) }
    it { should permit_access_to(:update) }
    it { should permit_access_to(:destroy) }
  end

  context "for a member" do
    let(:user) { FactoryGirl.build(:user, :member) }

    # CRUD actions
    it { should_not permit_access_to(:index) }
    it { should_not permit_access_to(:new) }
    it { should_not permit_access_to(:create) }
    it { should_not permit_access_to(:edit) }
    it { should_not permit_access_to(:update) }
    it { should_not permit_access_to(:destroy) }
  end
end
