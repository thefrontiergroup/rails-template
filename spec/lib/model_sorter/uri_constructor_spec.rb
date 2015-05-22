require 'spec_helper'

describe ModelSorter::UriConstructor do

  describe "#build_uri_with_cycled_sorting_params" do
    subject { ModelSorter::UriConstructor.new.build_uri_with_cycled_sorting_params(attribute, path, query_params).to_s }
    let(:attribute) { "dongle" }
    let(:path) { "www.google.com" }
    let(:query_params) { {"jordan" => "rules"}.merge(sorting_parameters) }

    # www.google.com
    context "with no existing sorting parameters" do
      let(:sorting_parameters) { {} }
      it { should eq("www.google.com?jordan=rules&sort_attribute=dongle&sort_direction=asc") }
    end

    context "with existing sorting parameters for the given attribute" do
      let(:sorting_parameters) { {"sort_attribute" => attribute, "sort_direction" => sort_direction} }

      # www.google.com?sort_attribute=dongle&sort_direction=asc
      context "sort_direction is asc" do
        let(:sort_direction) { "asc" }
        it { should eq("www.google.com?jordan=rules&sort_attribute=dongle&sort_direction=desc") }
      end

      # www.google.com?sort_attribute=dongle&sort_direction=desc
      context "sort_direction is desc" do
        let(:sort_direction) { "desc" }
        it { should eq("www.google.com?jordan=rules") }
      end
    end

    # www.google.com?sort_attribute=trepanning&sort_direction=asc
    context "with existing sorting parameters for another attribute" do
      let(:sorting_parameters) { {"sort_attribute" => "trepanning", "sort_direction" => "asc"} }
      it { should eq("www.google.com?jordan=rules&sort_attribute=dongle&sort_direction=asc") }
    end

  end

end
