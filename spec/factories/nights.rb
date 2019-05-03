FactoryBot.define do
  factory :night do
    date { Faker::Date.between(Date.current, 2.weeks.from_now) }
    reservation
    couch
  end
end
