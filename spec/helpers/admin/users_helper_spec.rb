require 'rails_helper'

describe Admin::UsersHelper do

  describe "#users_index_tab_for" do
    subject { helper.users_index_tab_for(label, path) }
    let(:label) { "Jordan Rules!" }
    let(:path)  { "dong_where_is_my_automobile" }

    before do
      stub_request = instance_double(ActionDispatch::Request)
      allow(stub_request).to receive(:path).and_return(current_path)
      allow(helper).to receive(:request).and_return(stub_request)
    end

    context "when the the current request's path is the same as the path passed through" do
      let(:current_path) { path }
      it { should include("<li class=\"active\"") }
      it { should include("<a href=\"#{path}\"") }
      it { should include(">#{label}</a>") }
    end

    context "when the the current request's path is not the same as the path passed through" do
      let(:current_path) { File.join(path, "other_part") }
      it { should_not include("<li class=\"active\"") }
      it { should include("<a href=\"#{path}\"") }
      it { should include(">#{label}</a>") }
    end
  end

end
