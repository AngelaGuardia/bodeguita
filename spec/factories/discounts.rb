FactoryBot.define do
  factory :discount do
    name { Faker::Hipster.word }
    percentage { Faker::Number.between(from: 0.0, to: 1.0) }
    minimum_quantity { Faker::Number.number(digits: 1) }
    association :user
  end
end
