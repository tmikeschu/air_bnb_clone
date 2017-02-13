FactoryGirl.define do
  factory :couch do
    cities = [{
                street_address: "233 S Wacker Dr",
                city: "Chicago",
                state: "IL",
                zipcode: "60606"},
              { street_address: "800 Decatur St",
                city: "New Orleans",
                state: "LA",
                zipcode: "70116"},
              { street_address: "1311 17th St",
                city: "Denver",
                state: "CO",
                zipcode: "80123"}
              ]

    this_city = cities.sample

    name           { Faker::GameOfThrones.character }
    description    { Faker::Hipster.sentence }
    street_address this_city[:street_address]
    city           this_city[:city]
    state          this_city[:state]
    zipcode        this_city[:zipcode]
    host           { create(:user) }
  end
end
