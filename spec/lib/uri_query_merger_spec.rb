require 'rails_helper'

RSpec.describe UriQueryMerger do

  describe '#merge' do
    subject { UriQueryMerger.new(uri, params).merge }
    let(:params) { {jordan: "rules"} }

    context "when there are no existing params" do
      let(:uri) { "http://www.google.com" }
      it { should eq("http://www.google.com?jordan=rules") }
    end

    context "when there are different existing params" do
      let(:uri) { "http://www.google.com?other=1" }
      it { should eq("http://www.google.com?other=1&jordan=rules") }
    end

    context "when the existing params are for the same merged attributes" do
      let(:uri) { "http://www.google.com?jordan=doesnt_rule" }
      it { should eq("http://www.google.com?jordan=rules") }
    end

  end

end
