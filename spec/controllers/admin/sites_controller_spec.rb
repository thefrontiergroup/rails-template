require 'rails_helper'

RSpec.describe Admin::SitesController do

  describe 'GET index' do
    subject(:get_index) { get :index, params }
    let(:params) { {} }

    authenticated_as(:admin) do
      it { should render_template(:index) }

      # describe_assign(:users) do
      #   subject(:users) { get_index; assigns(:users) }

        # describe "filtering by role" do
        #   it { should include(FactoryGirl.create(:site, :member)) }
        #   it { should_not include(FactoryGirl.create(:site, :admin)) }
        # end
      # end
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
#below is copied from the members controller, then pieces not relevant to sites have been removed or changed.

  describe 'POST create' do
    subject(:create_site) { post :create, site: params }
    let(:params) { {} }

    authenticated_as(:admin) do

      context "with valid parameters" do
        let(:params) do
          {
            name: "name name",
            rural: false,
            line_1: "5 fake street",
            post_code: "6533",
            state_id: 5
            # email: "email@example.com",
            # password: "password"
          }
        end

        it "creates a Site object with the given attributes" do
          site = Site.order(:created_at).last
          expect(site).to be_present
          expect(site).to have_attributes(params.slice(:site))
        end

        # it { should redirect_to admin_sites_path }
      end

      context "with invalid parameters" do
        let(:params) { {post_code: nil} }
        specify { expect { subject }.not_to change(Site, :count) }
      end
    end

    it_behaves_like "action requiring authentication"
    # it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'GET edit' do
    subject { get :edit, id: target_site.id }
    let(:target_site) { FactoryGirl.create(:site) }

    authenticated_as(:admin) do
      it { should be_success }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'POST update' do
    subject(:update_site) { post :update, id: target_site.id, site: params }
    let(:params) { {} }
    let(:target_site) { FactoryGirl.create(:site) }

    authenticated_as(:admin) do

      context "with valid parameters" do
        let(:params) do
          {
            name: "name name",
            rural: "false",
            line_1: "5 fake street",
            post_code: "6533",
            state_id: 5
          }
        end

        it "creates a Site object with the given attributes" do
          update_site

          target_site.reload
        end

        it { should redirect_to(admin_sites_path) }
      end

      context "with invalid parameters" do
        let(:params) do
          {
            name: "name name",
            rural: " ",
            line_1: " ",
            post_code: "6533",
            state_id: 5
          }
        end

        it "doesn't update the Site" do
          update_site
          expect(target_site.reload).not_to eq(site: params)
        end
      end
    end

    # it_behaves_like "action requiring authentication"
    # it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'DELETE destroy' do
    subject { delete :destroy, id: target_site.id }
    let(:target_site) { FactoryGirl.create(:site) }

    authenticated_as(:admin) do
      it "deletes the site" do
        subject
        expect(target_site.delete)
      end
      it { should redirect_to(admin_sites_path) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end
end