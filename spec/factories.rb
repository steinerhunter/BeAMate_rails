FactoryGirl.define do
  factory :user do

    sequence(:name) { |n| "Person#{n}" }
    sequence(:email) { |n| "person#{n}@gmail.com" }
    password  "MyPassword"
    password_confirmation "MyPassword"

    factory :admin do
      admin true
    end
  end

  factory :requestpost do
    content "Lorem ipsum"
    requested_item "Some tablet"
    willing_to_pay "50$"
    user
  end

  factory :matepost do
    content "Lorem ipsum"
    flying_to "United States"
    flying_from "Israel"
    departing_on "January 15th, 2013"
    returning_on "January 19th, 2013"
    user
  end
end