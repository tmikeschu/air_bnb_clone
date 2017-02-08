FactoryGirl.define do

  factory :user do
    first_name   { Faker::Name.first_name }
    last_name    { Faker::Name.last_name }
    email        { Faker::Internet.email }
    password     { Faker::Internet.password }
    phone_number { Faker::PhoneNumber.unique.phone_number }
  end

  factory :couch do
    cities = [{
                city: "Chicago",
                state: "IL",
                zipcode: "12345"},
              { city: "New Orleans",
                state: "LA",
                zipcode: "70112"},
              { city: "Chicago",
                state: "IL",
                zipcode: "12345"}
              ]

    this_city = cities.sample

    name           { Faker::Lorem.word }
    description    { Faker::Hipster.sentence }
    street_address { Faker::Address.street_address }
    city           this_city[:city]
    state          this_city[:state]
    zipcode        this_city[:zipcode]
    user
  end
end
