require 'rails_helper'

describe Admin::UsersController do

  describe 'GET index' do
    subject(:get_index) { get :index }

    authenticated_as(:admin) do
      it { should be_success }

      describe_assign(:users) do
        subject(:users) { get_index; assigns(:users) }

        describe "filtering" do
          it { should include(FactoryGirl.create(:user, :member)) }
          it { should_not include(FactoryGirl.create(:user, :admin)) }
        end

        describe "sorting" do
          it "sorts by query parameters" do
            expect(ModelSorter).to receive(:sort).with(instance_of(User::ActiveRecord_Relation), anything).and_call_original
            subject
          end
        end
      end
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'GET index_admins' do
    subject(:get_index) { get :index_admins }

    authenticated_as(:admin) do
      it { should be_success }

      describe_assign(:users) do
        subject(:users) { get_index; assigns(:users) }

        describe "filtering" do
          it { should include(FactoryGirl.create(:user, :admin)) }
          it { should_not include(FactoryGirl.create(:user, :member)) }
        end

        describe "sorting" do
          it "sorts by query parameters" do
            expect(ModelSorter).to receive(:sort).with(instance_of(User::ActiveRecord_Relation), anything).and_call_original
            subject
          end
        end
      end
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'GET new' do
    subject { get :new }

    authenticated_as(:admin) do
      it { should be_success }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
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
          expect(user).to have_attributes(params.slice(:email, :role))
        end

        it { should redirect_to(admin_users_path) }
      end

      context "with invalid parameters" do
        let(:params) { {email: nil} }
        specify { expect { subject }.not_to change(User, :count) }
      end
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'GET edit' do
    subject { get :edit, id: target_user.id }
    let(:target_user) { FactoryGirl.create(:user) }

    authenticated_as(:admin) do
      it { should be_success }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
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

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
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

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

end
