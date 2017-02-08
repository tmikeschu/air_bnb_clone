FactoryGirl.define do

  sequence(:email) { |n| "#{n}@test.com" }
  sequence(:phone_number) { |n| "#{n}123456789"}

  factory :user do
    first_name   Faker::Name.first_name
    last_name    Faker::Name.last_name
    email
    password     Faker::Internet.password
    phone_number
  end

  factory :couch do
    name           Faker::Lorem.word
    description    Faker::Hipster.sentence
    street_address Faker::Address.street_address
    city           Faker::Address.city
    state          Faker::Address.state
    zipcode        Faker::Address.zip_code
    user
  end
end
