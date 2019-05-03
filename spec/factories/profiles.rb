FactoryBot.define do
  factory :profile do
    description { Faker::Hipster.paragraph }
    image       { Faker::LoremPixel.image("50x60") }
    user
  end
end
