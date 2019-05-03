FactoryBot.define do
  factory :couch_photo do
    title { "MyString" }
    caption { "MyString" }
    image { "/spec/fixtures/test_couch.png" }
    couch
  end
end
