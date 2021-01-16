FactoryBot.define do
  factory :order_image do
    price { Faker::Commerce.price(range: 0..10.0) }
    quantity { Faker::Number.number(digits: 1) }
    association :order
    association :image
  end
end
