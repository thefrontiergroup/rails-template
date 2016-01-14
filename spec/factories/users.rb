FactoryGirl.define do

  factory :user do
    email    { FFaker::Internet.email }
    password "password"
    role User.roles["member"]
    # birth_date { rand(20..50).years.ago }

    site

    trait :admin do
      role User.roles["admin"]
    end

    trait :member do
      role User.roles["member"]
    end
  end

end
