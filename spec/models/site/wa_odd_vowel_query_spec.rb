require 'rails_helper'

RSpec.describe Site::WaOddVowelQuery do

  describe "users_in_wa_with_odd_vowels_in_name" do
    subject { Site::WaOddVowelQuery.new.users_in_wa_with_odd_vowels }

    let(:wa)          { FactoryGirl.create(:state, abbreviation: "WA") }
    let(:wa_address)  { FactoryGirl.create(:address, state: wa) }

    let!(:wa_site)    { FactoryGirl.create(:site, address: wa_address) }
    let!(:other_site) { FactoryGirl.create(:site) }

    it { should     include(FactoryGirl.create(:user, site: wa_site, first_name: "ee", last_name: "e")) }
    it { should_not include(FactoryGirl.create(:user, site: other_site, first_name: "ee", last_name: "e")) }
    it { should_not include(FactoryGirl.create(:user, site: wa_site, first_name: "a", last_name: "a")) }
  end
end