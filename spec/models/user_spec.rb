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

  describe '@family_name' do
    it { should validate_length_of(:family_name).is_at_most(255) }
    it { should validate_presence_of(:family_name) }
  end

  describe '@given_names' do
    it { should validate_length_of(:given_names).is_at_most(255) }
    it { should validate_presence_of(:given_names) }
  end

  describe '@password' do
    it { should validate_presence_of(:password) }
  end

  describe '@role' do
    it { should validate_presence_of(:role) }
  end

  describe '.ransack' do
    describe '.full_name' do
      subject { User.ransack({full_name_cont: "Jordan Maguire"}).result }

      it { should include(FactoryGirl.create(:user, given_names: "Jordan", family_name: "Maguire")) }
      it { should include(FactoryGirl.create(:user, given_names: "Jordan", family_name: "MAGUIRE")) }

      it { should_not include(FactoryGirl.create(:user, given_names: "Jordan", family_name: "Tuesday")) }
      it { should_not include(FactoryGirl.create(:user, given_names: "Tuesday", family_name: "Maguire")) }
    end
  end

  describe '#full_name' do
    subject { user.full_name }
    let(:user) do
      FactoryGirl.build_stubbed(:user, {
        given_names: given_names,
        family_name: family_name
      })
    end
    let(:given_names) { "Jordan" }
    let(:family_name) { "Maguire" }

    context "with both given_names and family_name" do
      it { should eq("Jordan Maguire") }
    end

    context "with only given_names" do
      let(:family_name) { nil }
      it { should eq("Jordan") }
    end

    context "with only family_name" do
      let(:given_names) { nil }
      it { should eq("Maguire") }
    end
  end

  describe '#to_s' do
    specify { expect(User.new(email: "yolo").to_s).to eq("yolo") }
  end

end
