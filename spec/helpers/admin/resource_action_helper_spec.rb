require 'rails_helper'

describe Admin::ResourceActionHelper do

  describe "#link_to_archive_resource" do
    subject(:link) { Nokogiri.parse(link_html).children.first }
    let(:link_html) { helper.link_to_archive_resource("my_path", "Jordan") }

    it "sets the href correctly" do
      expect(link["href"]).to eq("my_path")
    end

    it "sets a data-confirm message" do
      expect(link["data-confirm"]).to eq("Are you sure you want to archive Jordan?")
    end

    specify { expect(link.content).to eq("Archive") }
  end

end
