require 'spec_helper'

describe Admin::DashboardController do

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

end
