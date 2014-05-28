require 'spec_helper'

describe HomeController do

  describe 'GET index' do
    subject { get :index }
    it { should render_template(:index) }
  end

end
