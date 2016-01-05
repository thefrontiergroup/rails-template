require 'rails_helper'

RSpec.describe Member::DashboardController do

  describe 'GET index' do
    subject { get :index }

    authenticated_as(:member) do
      it { should be_success }
    end

    it_behaves_like "action requiring authentication"
  end

end
