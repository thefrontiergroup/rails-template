require 'rails_helper'

RSpec.describe User do

  describe '@email' do
    let!(:user)    { FactoryGirl.create(:user) }
    let(:new_user) { FactoryGirl.build(:user, email: user.email) }

    it { should validate_presence_of(:email) }

    it "validates uniqueness with other active users" do
      expect(new_user).to be_invalid
      expect(new_user.errors[:email]).to be_present
    end

    it "doesn't validate uniqueness with deleted users" do
      user.destroy
      expect(new_user).to be_valid
    end

    it "doesn't validate uniqueness of email when both users are deleted" do
      user.destroy
      new_user.save!
      new_user.deleted_at = user.deleted_at
      expect(new_user).to be_valid
    end
  end

  describe '@password' do
    it { should validate_presence_of(:password) }
  end

  describe '@role' do
    it { should validate_presence_of(:role) }
  end

  describe ".email_search" do
    subject { User.email_search("xyz") }

    it { should include(FactoryGirl.create(:user, email: "abc@xyz.com")) }
    it { should include(FactoryGirl.create(:user, email: "xyz@abc.com")) }
    it { should include(FactoryGirl.create(:user, email: "XyZ@ABC.cOm")) }
    it { should_not include(FactoryGirl.create(:user, email: "xyc@abz.com")) }
    it { should_not include(FactoryGirl.create(:user, email: "abc@abc.com")) }
  end

  # .created_at_between(start_date, end_date)
  describe ".created_at_between" do
    subject { User.created_at_between(start_date, end_date) }

    context "when start_date is before end_date" do
      let(:start_date) { Date.new(2016, 5, 19) }
      let(:end_date)   { Date.new(2016, 5, 20) }

      it { should_not include(FactoryGirl.create(:user, created_at: start_date - 1.day)) }
      it { should     include(FactoryGirl.create(:user, created_at: start_date)) }
      it { should     include(FactoryGirl.create(:user, created_at: end_date)) }
      it { should_not include(FactoryGirl.create(:user, created_at: end_date + 1.day)) }
    end

    context "when start_date and end_date are the same" do
      let(:start_date) { Date.new(2016, 5, 20) }
      let(:end_date)   { Date.new(2016, 5, 20) }

      it { should_not include(FactoryGirl.create(:user, created_at: start_date - 1.day)) }
      it { should     include(FactoryGirl.create(:user, created_at: start_date.beginning_of_day)) }
      it { should     include(FactoryGirl.create(:user, created_at: end_date.end_of_day)) }
      it { should_not include(FactoryGirl.create(:user, created_at: end_date + 1.day)) }
    end
  end

  describe ".with_site_named" do
    subject { User.with_site_named("xyz") }

    let!(:site_that_matches_exactly)         { FactoryGirl.create(:site, name: "xyz") }
    let!(:site_that_is_suffixed_with_match)  { FactoryGirl.create(:site, name: "abc@xyz") }
    let!(:site_that_is_prefixed_with_match)  { FactoryGirl.create(:site, name: "xyz@abc") }
    let!(:site_matching_with_different_case) { FactoryGirl.create(:site, name: "ABc@xYZ") }
    let!(:site_that_doesnt_match)            { FactoryGirl.create(:site, name: "dong") }

    it { should include(FactoryGirl.create(:user, site: site_that_matches_exactly)) }
    it { should include(FactoryGirl.create(:user, site: site_that_is_suffixed_with_match)) }
    it { should include(FactoryGirl.create(:user, site: site_that_is_prefixed_with_match)) }
    it { should include(FactoryGirl.create(:user, site: site_matching_with_different_case)) }
    it { should_not include(FactoryGirl.create(:user, site: site_that_doesnt_match)) }
 end

  describe ".in_state"  do
    subject { User.in_state(state.id) }

    # Caveman Method
    # let(:state)   { FactoryGirl.create(:state) }
    # let(:address) { FactoryGirl.create(:address, state: state) }
    # let(:site)    { FactoryGirl.create(:site, address: address) }
    # it { should include(FactoryGirl.create(:user, site: site)) }

    # let!(:other_state)   { FactoryGirl.create(:state) }
    # let(:other_address) { FactoryGirl.create(:address, state: other_state) }
    # let(:other_site)    { FactoryGirl.create(:site, address: other_address) }
    # it { should_not include(FactoryGirl.create(:user, site: other_site)) }

    # More organised Caveman Method
    let(:state)   { FactoryGirl.create(:state) }
    let(:address) { FactoryGirl.create(:address, state: address_state) }
    let(:site)    { FactoryGirl.create(:site, address: address) }

    context "with a matching state" do
      let(:address_state) { state }
      it { should include(FactoryGirl.create(:user, site: site)) }
    end

    context "with a different state" do
      let(:address_state) { FactoryGirl.create(:state) }
      it { should_not include(FactoryGirl.create(:user, site: site)) }
    end
  end

  describe ".in_post_code" do
    subject { User.in_post_code(matching_post_code) }
    let(:matching_post_code) { "6025" }

    let(:site)    { FactoryGirl.create(:site, address: address) }
    let(:address) { FactoryGirl.create(:address, post_code: address_post_code) }

    context "with matching post_code" do
      let(:address_post_code) { matching_post_code }
      it { should include(FactoryGirl.create(:user, site: site)) }
    end

    context "with a different post_code" do
      let(:address_post_code) { "6023" }
      it { should_not include(FactoryGirl.create(:user, site: site)) }
    end
  end
  # Updated_at_between, updated_at from start_date, updated_at to end_date
  describe ".updated_at_between" do
    subject { User.updated_at_between(start_date, end_date) }

    context "when start_date is before end_date" do
      let(:start_date) { Date.new(2016, 5, 19) }
      let(:end_date)   { Date.new(2016, 5, 20) }

      it { should_not include(FactoryGirl.create(:user, updated_at: start_date - 1.day)) }
      it { should     include(FactoryGirl.create(:user, updated_at: start_date)) }
      it { should     include(FactoryGirl.create(:user, updated_at: end_date)) }
      it { should_not include(FactoryGirl.create(:user, updated_at: end_date + 1.day)) }
    end

    context "when start_date and end_date are the same" do
      let(:start_date) { Date.new(2016, 5, 20) }
      let(:end_date)   { Date.new(2016, 5, 20) }

      it { should_not include(FactoryGirl.create(:user, updated_at: start_date - 1.day)) }
      it { should     include(FactoryGirl.create(:user, updated_at: start_date.beginning_of_day)) }
      it { should     include(FactoryGirl.create(:user, updated_at: end_date.end_of_day)) }
      it { should_not include(FactoryGirl.create(:user, updated_at: end_date + 1.day)) }
    end
  end

  describe ".updated_at_after" do
    subject { User.updated_at_after(start_date) }

     context "when start_date is only field" do
       let(:start_date) { Date.new(2016, 5, 19) }

       it { should_not include(FactoryGirl.create(:user, updated_at: start_date - 1.day)) }
       it { should     include(FactoryGirl.create(:user, updated_at: start_date.beginning_of_day)) }
     end
  end

  describe ".updated_at_before" do
    subject {User.updated_at_before(end_date) }

    context "when end_date is only field" do
      let(:end_date) {Date.new(2016, 5, 20) }

      it { should     include(FactoryGirl.create(:user, updated_at: end_date.end_of_day)) }
      it { should_not include(FactoryGirl.create(:user, updated_at: end_date + 1.day)) }
    end
  end

  describe ".in_rural_area" do
    subject {User.in_rural_area(true)}

    context "when rural is true" do
      let!  (:site)       { FactoryGirl.create(:site, rural: true) }
      let!(:rural_false)  { FactoryGirl.create(:site, rural: false) }

      it { should include(FactoryGirl.create(:user, site: site)) }
      it { should_not include(FactoryGirl.create(:user, site: rural_false)) }
    end
  end

  describe '#to_s' do
    specify { expect(User.new(email: "yolo").to_s).to eq("yolo") }
  end

end
