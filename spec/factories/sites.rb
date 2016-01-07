FactoryGirl.define do
  factory :site do
    association :address
    name  { FFaker::Name.name }
    rural [true, false].sample
  end

end
