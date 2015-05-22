require 'spec_helper'

describe ModelSorter do

  describe ".sort" do
    subject { ModelSorter.sort(scope, params) }
    let(:scope)  { User.all }
    let(:params) { {sort_attribute: "email", sort_direction: sort_direction} }

    context "when asc" do
      let(:sort_direction) { "asc" }

      it { should eq(User.all.order(email: :asc)) }
    end

    context "when desc" do
      let(:sort_direction) { "desc" }

      it { should eq(User.all.order(email: :desc)) }
    end

    context "when not asc or desc" do
      let(:sort_direction) { "sideways" }

      it { expect { subject }.to raise_error(ArgumentError) }
    end

    context "when nil" do
      let(:sort_direction) { nil }

      it "returns the collection, unordered" do
        should eq(scope)
      end
    end
  end

end
