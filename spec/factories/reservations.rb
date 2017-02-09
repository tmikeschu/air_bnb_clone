FactoryGirl.define do
  factory :reservation do
    traveler { create(:user) }
    status { 0 }
  end
end
