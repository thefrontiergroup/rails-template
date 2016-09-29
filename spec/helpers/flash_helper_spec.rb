require 'rails_helper'

describe FlashHelper do

  describe '#flash_class' do
    subject { helper.flash_class(level) }

    context "when notice" do
      let(:level) { "notice" }
      it { should eq("positive message") }
    end

    context "when success" do
      let(:level) { "success" }
      it { should eq("positive message") }
    end

    context "when error" do
      let(:level) { "error" }
      it { should eq("error message") }
    end

    context "when alert" do
      let(:level) { "alert" }
      it { should eq("negative message") }
    end
  end

end
