require 'rails_helper'

RSpec.describe State, type: :model do

  describe "@abbreviation" do
    before { FactoryGirl.create(:state) }
    it { should validate_uniqueness_of(:abbreviation) }
    it { should validate_presence_of(:abbreviation) }
  end

  describe "@name" do
    before { FactoryGirl.create(:state) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:name) }
  end

  describe "#to_s" do
    specify { expect(State.new(abbreviation: "QLD").to_s).to eq("QLD") }
  end

end
