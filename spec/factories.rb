FactoryGirl.define do

  factory :couch do
    name           Faker::Lorem.word
    description    Faker::Hipster.sentence
    street_address Faker::Address.street_address
    city           Faker::Address.city
    state          Faker::Address.state
    zipcode        Faker::Address.zip_code
  end

  factory :user do
    first_name   Faker::Name.first_name
    last_name    Faker::Name.last_name
    email        Faker::Internet.unique.email
    password     Faker::Internet.password
    phone_number Faker::Number.unique.number(10)
  end
end
