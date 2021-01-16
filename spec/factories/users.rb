FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name  }
    last_name { Faker::Name.last_name  }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
    email { Faker::Internet.free_email }

    factory :buyer do
      role { 0 }
    end

    factory :photographer do
      role { 1 }
    end

    trait :with_images do
      after(:create) do |user|
        create_list(:image, 5, user: user)
      end
    end
  end
end
