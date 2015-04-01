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

end
