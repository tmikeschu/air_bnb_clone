require 'rails_helper'

RSpec.describe Couch, type: :model do
  context "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zipcode }
  end

  context "relationships" do
    it { should belong_to(:host).class_name("User") }
    it { should have_many(:nights) }
    it { should have_many(:reservations).through(:nights) }
  end

  context "methods" do
    before do
      create_list(:couch, 2, city: "This City")
      create(:couch, city: "That City")
    end

    describe ".in_city()" do
      it "returns couches for a given city" do
        result = Couch.in_city("This City")
        expect(result.count).to eq 2
      end
    end

    describe ".search()" do
      it "returns couches for a given city and date range" do
        couch_1, couch_2, couch_3 = Couch.all[0..2]
        couch_1.nights << create(:night, date: Date.yesterday)
        couch_1.nights << create(:night, date: Date.current)
        couch_1.nights << create(:night, date: Date.tomorrow)
        couch_2.nights << create(:night, date: Date.current + 10.days)
        couch_3.nights << create(:night, date: Date.yesterday)
        couch_3.nights << create(:night, date: Date.current)
        couch_3.nights << create(:night, date: Date.tomorrow)

        params = { "Destination" => "This City", "Check In" => Date.yesterday.to_s, "Check Out" => Date.tomorrow.tomorrow.to_s }
        result = Couch.search(params)

        expect(result.count).to eq 1
        expect(result).to be_a Couch::ActiveRecord_Relation
      end
    end
  end
end
