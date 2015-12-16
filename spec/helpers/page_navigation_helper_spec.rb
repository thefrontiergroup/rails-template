require 'rails_helper'

describe PageNavigationHelper do

  describe "#page_navigation_link_to" do
    subject { helper.page_navigation_link_to(title, path) }
    let(:title) { "Users" }
    let(:path)  { admin_members_path }

    before do
      request_double = double
      allow(helper).to receive(:request).and_return(request_double)
      allow(request_double).to receive(:url).and_return(url)
    end

    context "when url matches the provided path" do
      let(:url) { "/admin/members" }
      it { should eq("<li class=\"active\"><a href=\"/admin/members\">Users</a></li>") }
    end

    context "when url is a subpath that includes provided path" do
      let(:url) { "/admin/members/1/edit" }
      it { should eq("<li class=\"active\"><a href=\"/admin/members\">Users</a></li>") }
    end

    context "when url doesn't matches the provided path" do
      let(:url) { "/admin/dogs" }
      it { should eq("<li><a href=\"/admin/members\">Users</a></li>") }
    end
  end

end
