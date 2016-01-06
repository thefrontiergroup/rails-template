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

  describe ".with_site_named", :focus do
    subject { User.with_site_named("xyz") }

    let!(:matching_site)     { FactoryGirl.create(:site, name: "xyz") }
    let!(:non_matching_site) { FactoryGirl.create(:site, name: "dong") }

    it { should include(FactoryGirl.create(:user, site: matching_site)) }
    it { should_not include(FactoryGirl.create(:user, site: non_matching_site)) }
  end

  describe '#to_s' do
    specify { expect(User.new(email: "yolo").to_s).to eq("yolo") }
  end

end
