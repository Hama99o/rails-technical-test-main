FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { "password123" }
    balance { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end
end