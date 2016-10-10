require 'rails_helper'

RSpec.describe AfterSignInPath do
  include Rails.application.routes.url_helpers

  let(:path) { AfterSignInPath.new(user) }

  describe "#to_s" do
    subject { path.to_s }

    context "when admin" do
      let(:user) { FactoryGirl.build(:user, :admin) }
      it { should eq(admin_dashboard_index_path) }
    end

    context "when member" do
      let(:user) { FactoryGirl.build(:user, :member) }
      it { should eq(dashboard_path) }
    end

    context "when nil" do
      let(:user) { nil }
      it { should eq(root_path) }
    end
  end

end
