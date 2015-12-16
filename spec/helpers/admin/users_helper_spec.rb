require 'rails_helper'

describe Admin::UsersHelper do

  describe "#edit_path_for_user" do
    subject { helper.edit_path_for_user(user) }
    let(:user) { FactoryGirl.build(:user, role: role, id: 666) }

    context "when the user is admin" do
      let(:role) { :admin }
      it { should eq(edit_admin_admin_path(user)) }
    end

    context "when the user is member" do
      let(:role) { :member }
      it { should eq(edit_admin_member_path(user)) }
    end

    context "when the user is another role" do
      let(:role) { :jordan }
      specify { expect { subject }.to raise_error(ArgumentError) }
    end
  end

  describe "#delete_path_for_user" do
    subject { helper.delete_path_for_user(user) }
    let(:user) { FactoryGirl.build(:user, role: role, id: 666) }

    context "when the user is admin" do
      let(:role) { :admin }
      it { should eq(admin_admin_path(user)) }
    end

    context "when the user is member" do
      let(:role) { :member }
      it { should eq(admin_member_path(user)) }
    end

    context "when the user is another role" do
      let(:role) { :jordan }
      specify { expect { subject }.to raise_error(ArgumentError) }
    end
  end

end
