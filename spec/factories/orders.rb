FactoryBot.define do
  factory :order do
    billing_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
    cc_number { Faker::Stripe.valid_card }
    cc_name { Faker::Name.name }
    status { "Approved" }
    association :user
  end
end
