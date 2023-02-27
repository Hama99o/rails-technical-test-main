FactoryBot.define do
  factory :pokemon do
    user
    name { Faker::Games::Pokemon.name }
    price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    height { Faker::Number.between(from: 1, to: 100) }
    weight { Faker::Number.between(from: 1, to: 1000) }
    image_path { Faker::LoremPixel.image(size: "200x200") }
  end
end