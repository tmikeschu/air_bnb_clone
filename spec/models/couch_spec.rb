require 'rails_helper'
include ModelHelpers

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
    it { should have_many(:photos) }
  end

  context "methods" do
    before do
      create_list(:couch, 2, street_address: "1311 17th St", city: "Denver", state: "CO", zipcode: "80123")
      create(:couch, city: "Hammond", state: "LA", zipcode: "46320")
    end

    describe ".in_city()" do
      it "returns couches for a given city" do
        result = Couch.in_city("Denver")
        expect(result.length).to eq 2
      end
    end


    describe ".search()" do
      before do
        couch_1, couch_2, couch_3 = Couch.all[0..2]
        couch_1.nights << create(:night, date: Date.current)
        couch_1.nights << create(:night, date: Date.tomorrow)

        couch_2.nights << create(:night, date: Date.current + 10.days)

        last_night = build(:night, date: Date.yesterday)
        last_night.save(validate: false)
        couch_3.nights << last_night
        couch_3.nights << create(:night, date: Date.current)
        couch_3.nights << create(:night, date: Date.tomorrow)
      end

      it "returns couches for a city and date range case insensitive" do
        params = { 
          "Destination" => "DENVer",
          "Check In" => Date.yesterday.to_date_picker_format,
          "Check Out" => Date.tomorrow.tomorrow.to_date_picker_format
        }
        result = Couch.search(params)

        expect(result.length).to eq 1
        expect(result).to be_a Couch::ActiveRecord_Relation
      end

      it "returns couches for a given city and date range" do
        params = {
          "Destination" => "Denver",
          "Check In" => Date.yesterday.to_date_picker_format,
          "Check Out" => Date.tomorrow.tomorrow.to_date_picker_format
        }
        result = Couch.search(params)
        
        expect(result.length).to eq 1
        expect(result).to be_a Couch::ActiveRecord_Relation
      end
    end
  end
end
