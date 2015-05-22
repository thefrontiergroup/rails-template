require 'spec_helper'

describe ModelSorter::QueryString do

  describe "#hash_with_cycled_sorting_params" do
    subject { ModelSorter::QueryString.new.hash_with_cycled_sorting_params(attribute, sorting_parameters) }
    let(:attribute) { "dongle" }

    context "with no existing sorting parameters" do
      let(:sorting_parameters) { {} }
      it { should eq({sort_attribute: "dongle", sort_direction: "asc"}) }
    end

    context "with existing sorting parameters for the given attribute" do
      let(:sorting_parameters) { {sort_attribute: attribute, sort_direction: sort_direction} }

      context "sort_direction is asc" do
        let(:sort_direction) { "asc" }
        it { should eq({sort_attribute: "dongle", sort_direction: "desc"}) }
      end

      context "sort_direction is desc" do
        let(:sort_direction) { "desc" }
        it { should eq({}) }
      end
    end

    context "with existing sorting parameters for another attribute" do
      let(:sorting_parameters) { {sort_attribute: "trepanning", sort_direction: "asc"} }
      it { should eq({sort_attribute: "dongle", sort_direction: "asc"}) }
    end
  end

end
