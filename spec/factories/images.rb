FactoryBot.define do
  factory :image do
    name { Faker::Hipster.word }
    description { Faker::Hipster.sentence }
    price { Faker::Number.number(digits: 2) }
    url { Faker::Company.logo }
    inventory { Faker::Number.number(digits: 2) }
    association :user
  end
end
