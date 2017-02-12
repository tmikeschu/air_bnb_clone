require "rails_helper"

RSpec.describe NightFinder do
  before do
    create_list(:couch, 2, city: "This City")
    create(:couch, city: "That City")
    @couch_1, couch_2, couch_3 = Couch.all[0..2]
    @couch_1.nights << create(:night, date: Date.current)
    @couch_1.nights << create(:night, date: Date.tomorrow)
    couch_2.nights << create(:night, date: Date.current + 10.days)
    couch_3.nights << create(:night, date: Date.current)
    couch_3.nights << create(:night, date: Date.tomorrow)
    @nights_params = { "check_in" => Date.current.to_s, "check_out" => Date.tomorrow.tomorrow.to_s, "couch_id" => @couch_1.id }
  end

  describe ".find" do
    it "returns the nights in a given range for a couch" do
      result   = NightFinder.find(@nights_params)
      checkin  = @nights_params["check_in"]
      checkout = @nights_params["check_out"]
      in_range = result.pluck(:date).all? { |date| date.to_s.between?(checkin, checkout) }

      expect(result).to be_an Night::ActiveRecord_Relation
      expect(result.count).to eq 2
      expect(result.pluck(:couch_id).uniq).to eq [@couch_1.id]
      expect(in_range).to be true
    end
  end

  describe "#find_nights" do
    it "returns the nights for a given date range and couch" do
      result   = NightFinder.find(@nights_params)
      checkin  = @nights_params["check_in"]
      checkout = @nights_params["check_out"]
      right_id = result.pluck(:couch_id).all? { |id| id == @couch_1.id }
      in_range = result.pluck(:date).all? { |date| date.to_s.between?(checkin, checkout) }

      expect(result).to be_an Night::ActiveRecord_Relation
      expect(result.count).to eq 2
      expect(right_id).to be true
      expect(in_range).to be true
    end
  end
end
