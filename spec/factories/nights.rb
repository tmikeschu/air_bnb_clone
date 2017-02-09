FactoryGirl.define do
  factory :night do
    date { Date.current }
    reservation
    couch 
  end
end
