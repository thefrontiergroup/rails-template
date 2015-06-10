require 'rails_helper'

describe Member::UsersController do

  describe 'GET edit' do
    subject { get :edit, id: member.id }

    let(:member) { FactoryGirl.create(:user, :member) }
    authenticated_as(:member) do
      it { should be_success }
    end

    it_behaves_like "action requiring authentication"
  end

  describe 'POST update' do
    subject(:update_user) { post :update, id: member.id, user: params }
    let(:params) { {} }

    let(:member) { FactoryGirl.create(:user, :member) }
    authenticated_as(:admin) do
      context "with valid parameters" do
        let(:params) do
          {
            email: "jordan@example.com",
            password: ""
          }
        end

        it "creates a User object with the given attributes" do
          update_user

          member.reload
          expect(member.email).to eq("jordan@example.com")
        end

        it { should redirect_to(member_dashboard_index_path) }
      end

      context "with invalid parameters" do
        let(:params) do
          {
            email: "not_an_email"
          }
        end

        it "doesn't update the User" do
          update_user
          expect(member.reload.email).not_to eq(params[:email])
        end
      end
    end

    it_behaves_like "action requiring authentication"
  end

end
