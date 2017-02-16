FactoryGirl.define do
  factory :message do
    reservation
    content { Faker::Lorem.paragraph }
    author { create(:user) }
  end
end
