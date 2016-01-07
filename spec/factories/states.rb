FactoryGirl.define do
  factory :state do
    abbreviation { FFaker::AddressAU.state_abbr }
    name { FFaker::AddressAU.state }
  end

end
