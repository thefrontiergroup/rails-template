require 'rails_helper'

RSpec.describe Site, type: :model do

  describe "@name" do
    it { should validate_presence_of(:name) }
  end

  describe "@address" do
    it { should validate_presence_of(:address) }
  end

  describe ".named" do
    subject { Site.named("xyz") }

    let!(:site_that_matches_exactly)         { FactoryGirl.create(:site, name: "xyz") }
    let!(:site_that_is_suffixed_with_match)  { FactoryGirl.create(:site, name: "abc@xyz") }
    let!(:site_that_is_prefixed_with_match)  { FactoryGirl.create(:site, name: "xyz@abc") }
    let!(:site_matching_with_different_case) { FactoryGirl.create(:site, name: "ABc@xYZ") }
    let!(:site_that_doesnt_match)            { FactoryGirl.create(:site, name: "dong") }

    it { should include(site_that_matches_exactly) }
    it { should include(site_that_is_suffixed_with_match) }
    it { should include(site_that_is_prefixed_with_match) }
    it { should include(site_matching_with_different_case) }
    it { should_not include(site_that_doesnt_match) }
  end

end