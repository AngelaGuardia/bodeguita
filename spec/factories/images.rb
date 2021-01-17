FactoryBot.define do
  factory :image do
    name { Faker::Hipster.word }
    description { Faker::Hipster.sentence }
    price { Faker::Commerce.price(range: 1..10.0) }
    url { Faker::Company.logo }
    inventory { Faker::Number.number(digits: 2) }
    association :user
  end
end
