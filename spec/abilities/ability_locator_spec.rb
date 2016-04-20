require 'rails_helper'

RSpec.describe AbilityLocator do

  describe "#get_ability" do
    subject { AbilityLocator.new(user).get_ability }

    context "when user is nil" do
      let(:user) { nil }
      it { should be_kind_of(BaseAbility) }
    end

    context "when user is an admin" do
      let(:user) { FactoryGirl.build(:user, :admin) }
      it { should be_kind_of(AdminAbility) }
    end

    context "when user is a member" do
      let(:user) { FactoryGirl.build(:user, :member) }
      it { should be_kind_of(MemberAbility) }
    end

    context "when user is not a known role" do
      let(:user) { FactoryGirl.build(:user, role: "paladin") }
      it "raises an exception" do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

end
