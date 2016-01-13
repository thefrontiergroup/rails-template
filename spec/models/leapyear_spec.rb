require 'rails_helper'

describe Leap_Year do

  describe "is it a leap year?" do
    subject { Leap_Year.new.is_leap_year(year) }

    describe "is divisble by 4" do
      let(:year) { 1716 }

      it { should eq(true) }
    end

    describe "is not divisible by 4" do
      let(:year) { 1715 }

      it { should eq(false) }
    end

    describe "year is divisible by 100 but not divisible by 400" do
      let(:year) { 1700 }

      it { should eq(false) }
    end

    describe "year is divisible by 100 and divisble by 400" do
      let(:year) { 1600 }

      it { should eq(true) }
    end
  end
end