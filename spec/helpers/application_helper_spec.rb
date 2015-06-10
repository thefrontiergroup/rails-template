require 'rails_helper'

describe ApplicationHelper do

  describe "#sortable_heading_for" do
    subject { helper.sortable_heading_for(attribute) }
    let(:attribute) { "dongle" }

    before do
      stub_request = instance_double(ActionDispatch::Request)
      allow(stub_request).to receive(:path).and_return("x")
      allow(stub_request).to receive(:query_parameters).and_return({sort_direction: "asc"})
      allow(helper).to receive(:request).and_return(stub_request)
    end

    it "returns a link with the sortable URL" do
      expected_uri = "www.jordan_rules.com"
      expect_any_instance_of(ModelSorter::UriConstructor).to receive(:build_uri_with_cycled_sorting_params).and_return(expected_uri)

      should include("href=\"#{expected_uri}\"")
    end

    it "includes the titleized attribute" do
      should include(">Dongle</a>")
    end

    it "includes the sort direction as a class" do
      should include("sortable asc")
    end
  end

end
