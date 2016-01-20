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

  describe "user search by email" do
    subject { User.email_search("xyz") }

    it { should include(FactoryGirl.create(:user, email: "abc@xyz.com")) }
    it { should include(FactoryGirl.create(:user, email: "xyz@abc.com")) }
    it { should include(FactoryGirl.create(:user, email: "XyZ@ABC.cOm")) }
    it { should_not include(FactoryGirl.create(:user, email: "xyc@abz.com")) }
    it { should_not include(FactoryGirl.create(:user, email: "abc@abc.com")) }
  end

  describe '#to_s' do
    specify { expect(User.new(email: "yolo").to_s).to eq("yolo") }
  end

end
