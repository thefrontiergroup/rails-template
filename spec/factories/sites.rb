FactoryGirl.define do
  factory :site do
    name  { FFaker::Name.name }
    rural [true, false].sample
  end

end
