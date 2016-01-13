require 'rails_helper'

describe Fibonacci do

  describe "#is_fibonacci?" do
    subject { Fibonacci.new.is_fibonacci?(num) }

    describe "number is negative" do
      let(:num) { -1 }

      it {should eq( false) }
    end

    describe "is fibonacci number" do
      let(:num) { 34 }

      it { should eq( true ) }
    end

    describe "not fibonacci number" do
      let(:num) { 40 }

      it { should eq( false) }
    end
  end

  describe "#fibonacci_generator" do
    subject { Fibonacci.new.fibonacci_generator(num) }

    describe "number is negative" do
      let(:num) { -1 }

      it { should eq([]) }
    end

    describe "number is one" do
      let(:num) { 1 }

      it {should eq([0]) }
    end

    describe "number is two" do
      let(:num) { 2 }

      it {should eq([0, 1]) }
    end

    describe "number is three" do
      let(:num) { 3 }

      it { should eq( [0, 1, 1]) }
    end

    describe "number is five" do
      let(:num) { 5 }

      it { should eq( [0, 1, 1, 2, 3]) }
    end
  end
end
