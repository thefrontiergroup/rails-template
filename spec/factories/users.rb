FactoryGirl.define do

  factory :user do
    email       { FFaker::Internet.email }
    given_names { FFaker::Name.first_name }
    family_name { FFaker::Name.last_name }
    password    "password"
    role        "member"

    trait :admin do
      role "admin"
    end

    trait :member do
      role "member"
    end
  end

end
