require 'rails_helper'

RSpec.describe PolicySupport do

  class PolicySupportTestClass
    include PolicySupport
  end

  describe "#is_admin?" do
    subject { instance.is_admin? }
    let(:instance) { PolicySupportTestClass.new(user, record) }
    let(:record) { nil }

    context "when user is nil" do
      let(:user) { nil }
      it { should be_falsey }
    end

    context "when user is member" do
      let(:user) { FactoryGirl.create(:user, :member) }
      it { should be_falsey }
    end

    context "when user is admin" do
      let(:user) { FactoryGirl.create(:user, :admin) }
      it { should be_truthy }
    end
  end

  describe "#is_member?" do
    subject { instance.is_member? }
    let(:instance) { PolicySupportTestClass.new(user, record) }
    let(:record) { nil }

    context "when user is nil" do
      let(:user) { nil }
      it { should be_falsey }
    end

    context "when user is member" do
      let(:user) { FactoryGirl.create(:user, :member) }
      it { should be_truthy }
    end

    context "when user is admin" do
      let(:user) { FactoryGirl.create(:user, :admin) }
      it { should be_falsey }
    end
  end

end
