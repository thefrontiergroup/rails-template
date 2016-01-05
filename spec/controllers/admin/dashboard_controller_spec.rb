require 'rails_helper'

RSpec.describe Admin::DashboardController do

  describe 'GET index' do
    subject { get :index }

    authenticated_as(:admin) do
      it { should be_success }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

end
