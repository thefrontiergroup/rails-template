require 'rails_helper'

describe ModelSorter do

  describe ".sort" do
    subject { ModelSorter.sort(scope, params, default_sort_order) }

    let(:scope)  { User.all }
    let(:params) { {sort_attribute: "email", sort_direction: sort_direction} }
    let(:default_sort_order) { nil }

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

      context "and a sort option is passed through" do
        let(:default_sort_order) { :id }

        it "returns the collection sorted by the given parameters" do
          should eq(scope.order(:id))
        end
      end

      context "and no sort option is passed through" do
        it "returns the collection, unordered" do
          should eq(scope)
        end
      end

    end
  end

end
