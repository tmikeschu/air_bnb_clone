FactoryGirl.define do
  factory :couch do
    cities = [{
                city: "Chicago",
                state: "IL",
                zipcode: "12345"},
              { city: "New Orleans",
                state: "LA",
                zipcode: "70112"},
              { city: "Denver",
                state: "CO",
                zipcode: "80123"}
              ]

    this_city = cities.sample

    name           { Faker::GameOfThrones.character }
    description    { Faker::Hipster.sentence }
    street_address { Faker::Address.street_address }
    city           this_city[:city]
    state          this_city[:state]
    zipcode        this_city[:zipcode]
    host           { create(:user) }
  end
end
