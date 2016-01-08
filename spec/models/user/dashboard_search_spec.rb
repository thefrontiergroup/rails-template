require 'rails_helper'

RSpec.describe User::DashboardSearch do

  describe "#users" do
    subject { User::DashboardSearch.new(original_scope, search_params).users }

    let(:original_scope) { User.all }
    let(:search_params)  { {} }

    context "when no search params are provided" do
      let(:search_params)  { {} }

      it "returns all users (ie: The original scope that was passed through)" do
        should include(FactoryGirl.create(:user))
      end
    end

    describe "scoping users by email" do
      let(:search_params)  { {email: "jordan@example.com"} }

      it { should     include(FactoryGirl.create(:user, email: "jordan@example.com")) }
      it { should_not include(FactoryGirl.create(:user, email: "another_guy@example.com")) }
    end

  end

end