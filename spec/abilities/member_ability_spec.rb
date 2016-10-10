require 'rails_helper'
require 'cancan/matchers'

describe MemberAbility do

  subject { ability }

  let(:ability) { MemberAbility.new(user) }
  let(:user) { FactoryGirl.create(:user, :member) }

  it { should_not be_able_to(:show, :admin_controllers) }

  describe "showing Dashboards" do
    it { should be_able_to(:show, :user_dashboard) }
    it { should_not be_able_to(:show, :admin_dashboard) }
  end

  describe "managing Users" do
    it { should be_able_to(:manager, user) }
    it { should_not be_able_to(:manager, FactoryGirl.create(:user, :member)) }
  end

end
