require 'spec_helper'

describe Admin::UsersController do

  describe 'GET index' do
    subject { get :index }

    authenticated_as(:admin) do
      it { should be_success }
    end

    authenticated_as(:member) do
      it_behaves_like "unauthorized access to controller action"
    end

    it_behaves_like "action requiring authentication"
  end

  describe 'GET new' do
    subject { get :new }

    authenticated_as(:admin) do
      it { should be_success }
    end

    authenticated_as(:member) do
      it_behaves_like "unauthorized access to controller action"
    end

    it_behaves_like "action requiring authentication"
  end

  describe 'POST create' do
    subject(:create_user) { post :create, user: params }
    let(:params) { {} }

    authenticated_as(:admin) do

      context "with valid parameters" do
        let(:params) do
          {
            email: "jordan@example.com",
            role: "member",
            password: "password"
          }
        end

        it "creates a User object with the given attributes" do
          create_user

          user = User.order(:created_at).last
          expect(user).to be_present
          expect(user.email).to eq("jordan@example.com")
          expect(user).to be_member
        end

        it { should redirect_to(admin_users_path) }
      end

      context "with invalid parameters" do
        specify { expect { subject }.not_to change(User, :count) }
      end
    end

    authenticated_as(:member) do
      it_behaves_like "unauthorized access to controller action"
    end

    it_behaves_like "action requiring authentication"
  end

  describe 'GET edit' do
    subject { get :edit, id: target_user.id }
    let(:target_user) { FactoryGirl.create(:user) }

    authenticated_as(:admin) do
      it { should be_success }
    end

    authenticated_as(:member) do
      it_behaves_like "unauthorized access to controller action"
    end

    it_behaves_like "action requiring authentication"
  end

  describe 'POST update' do
    subject(:update_user) { post :update, id: target_user.id, user: params }
    let(:params) { {} }
    let(:target_user) { FactoryGirl.create(:user) }

    authenticated_as(:admin) do

      context "with valid parameters" do
        let(:params) do
          {
            email: "jordan@example.com",
            role: "member",
            password: ""
          }
        end

        it "creates a User object with the given attributes" do
          update_user

          target_user.reload
          expect(target_user.email).to eq("jordan@example.com")
        end

        it { should redirect_to(admin_users_path) }
      end

      context "with invalid parameters" do
        let(:params) do
          {
            email: "not_an_email"
          }
        end

        it "doesn't update the User" do
          update_user
          expect(target_user.reload.email).not_to eq(params[:email])
        end
      end
    end

    authenticated_as(:member) do
      it_behaves_like "unauthorized access to controller action"
    end

    it_behaves_like "action requiring authentication"
  end

  describe 'DELETE destroy' do
    subject { delete :destroy, id: target_user.id }
    let(:target_user) { FactoryGirl.create(:user) }

    authenticated_as(:admin) do
      it "deletes the user" do
        subject
        expect(target_user.reload.deleted_at).to be_present
      end
      it { should redirect_to(admin_users_path) }
    end

    authenticated_as(:member) do
      it_behaves_like "unauthorized access to controller action"
    end

    it_behaves_like "action requiring authentication"
  end

end
