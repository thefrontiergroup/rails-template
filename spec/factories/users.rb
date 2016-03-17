FactoryGirl.define do

  factory :user do
    email    { FFaker::Internet.email }
    password "password"
    role "member"

    trait :admin do
      role "admin"
    end

    trait :member do
      role "member"
    end
  end

end
