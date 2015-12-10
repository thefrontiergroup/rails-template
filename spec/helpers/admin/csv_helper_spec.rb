require 'rails_helper'

RSpec.describe Admin::CsvHelper do

  describe '#link_to_csv' do
    let(:request) { double }

    before do
      expect(request).to receive(:url).and_return("http://www.google.com")
    end

    context "with html_options" do
      subject { helper.link_to_csv(request, html_options) }
      let(:html_options) { {jordan: "rules"} }

      it { should eq("<a jordan=\"rules\" href=\"http://www.google.com?format=csv\">Download CSV</a>") }
    end

    context "without html_options" do
      subject { helper.link_to_csv(request) }

      it { should eq("<a class=\"btn\" href=\"http://www.google.com?format=csv\">Download CSV</a>") }
    end
  end

end
