FactoryGirl.define do
  factory :address do
    line_1  { FFaker::AddressAU.street_address }
    line_2  { FFaker::AddressAU.secondary_address }
    city    { FFaker::AddressAU.city }
    state_id 1
    post_code { FFaker::AddressAU.postcode }
  end

end
