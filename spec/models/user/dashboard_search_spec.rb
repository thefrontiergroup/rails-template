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

    describe "scoping users by post_code" do
      let(:search_params) { {post_code: "1234"} }

      let(:site)    { FactoryGirl.create(:site, address: address) }
      let(:address) { FactoryGirl.create(:address, post_code: post_code ) }

      context "scoping by post_code" do
        context "when post_code matches" do
          let(:post_code) { "1234" }
          it { should include(FactoryGirl.create(:user, site: site)) }
        end
        context "when post_code doesn't match" do
          let(:post_code) { "0001" }
          it { should_not include(FactoryGirl.create(:user, site: site)) }
        end
      end
    end

    describe "scoping users site_ids" do
      let(:search_params) { {site_ids: [site_id]} }
      let(:site_id) { 666 }

      it { should     include(FactoryGirl.create(:user, site_id: site_id)) }
      it { should_not include(FactoryGirl.create(:user)) }
    end

    describe "scoping with state_id" do
      let(:search_params) { {state_id: searched_state.id} }
      let(:searched_state) { FactoryGirl.create(:state) }

      let(:site)    { FactoryGirl.create(:site, address: address) }
      let(:address) { FactoryGirl.create(:address, state: state) }

      context "scoping state_id" do
        context "matching state_id" do
          let(:state) { searched_state }
          it { should include(FactoryGirl.create(:user, site: site)) }
        end

        context "not matching state_id" do
          let(:state) { FactoryGirl.create(:state) }
          it { should_not include(FactoryGirl.create(:user, site: site)) }
        end
      end
    end

    describe "scoping rural users" do
      let(:search_params) { {rural: true} }
      let!(:rural_true)   { FactoryGirl.create(:site, rural: true) }
      let!(:rural_false)  { FactoryGirl.create(:site, rural: false) }

      it { should     include(FactoryGirl.create(:user, site: rural_true)) }
      it { should_not include(FactoryGirl.create(:user, site: rural_false)) }
    end

    describe "scoping by updated_at", focus: true do
      let(:search_params) do
        {
          updated_from: format_as_date(updated_from, date_format),
          updated_until: format_as_date(updated_until, date_format)
        }
      end
      let(:date_format) { "%d/%m/%Y" }

      def format_as_date(date, format)
        if date.present?
          date.strftime(format)
        end
      end

      context "when updated_from and updated_until are set" do
        let(:updated_until) { Date.new(2016, 6, 22) }
        let(:updated_from)  { Date.new(2016, 6, 21) }

        it { should_not include(FactoryGirl.create(:user, updated_at: updated_from - 1.day)) }
        it { should     include(FactoryGirl.create(:user, updated_at: updated_from)) }
        it { should     include(FactoryGirl.create(:user, updated_at: updated_until)) }
        it { should_not include(FactoryGirl.create(:user, updated_at: updated_until + 1.day)) }
      end

      context "when updated_from and updated_until are the same" do
        let(:updated_from)  { Date.new(2016, 5, 20) }
        let(:updated_until) { Date.new(2016, 5, 20) }

        it { should_not include(FactoryGirl.create(:user, updated_at: updated_from - 1.day)) }
        it { should     include(FactoryGirl.create(:user, updated_at: updated_from.beginning_of_day)) }
        it { should     include(FactoryGirl.create(:user, updated_at: updated_until.end_of_day)) }
        it { should_not include(FactoryGirl.create(:user, updated_at: updated_until + 1.day)) }
      end

      context "when only updated_from is set" do
        let(:updated_until) { nil }
        let(:updated_from) { Date.new(2016, 6, 20)}

        it { should_not include(FactoryGirl.create(:user, updated_at: updated_from - 1.day)) }
        it { should     include(FactoryGirl.create(:user, updated_at: updated_from.beginning_of_day)) }
      end

      context "when only updated_until is set" do
        let(:updated_from) { nil }
        let(:updated_until) { Date.new(2016, 6, 21)}

        it { should     include(FactoryGirl.create(:user, updated_at: updated_until.end_of_day)) }
        it { should_not include(FactoryGirl.create(:user, updated_at: updated_until + 1.day)) }
      end
    end
  end
end