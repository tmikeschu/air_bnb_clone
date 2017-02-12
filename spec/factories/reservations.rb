FactoryGirl.define do
  factory :reservation do
    traveler { create(:user) }
    status { 0 }

    factory :reservation_with_couch do
      after(:create) do |reservation|
        couch = create(:couch)
        night = create(:night, couch: couch, reservation: reservation)
      end
    end
  end
end
