FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { "password123" }
    balance { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end
end