FactoryGirl.define do
  factory :night do
    date { Faker::Date.between(2.weeks.ago, 2.weeks.from_now) }
    reservation
    couch 
  end
end
