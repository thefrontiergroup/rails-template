require 'spec_helper'

describe User do

  describe '@role' do
    it { should validate_presence_of(:role) }
  end

  describe '#to_s' do
    specify { expect(User.new(email: "yolo").to_s).to eq("yolo") }
  end

end
