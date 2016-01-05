require 'rails_helper'

RSpec.describe ApplicationController do

  describe "Pundit::NotAuthorizedError" do
    controller do
      def index
        raise Pundit::NotAuthorizedError
      end
    end

    subject { get :index }

    it { should redirect_to(root_path) }

    it 'should display the unauthorized flash message' do
      subject
      expect(request.flash[:alert]).to include "You are not authorized to perform this action."
    end
  end

end
