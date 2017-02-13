require "rails_helper"
include ModelHelpers

RSpec.describe NightFinder do
  let!(:today) { Date.current }
  let!(:two_days_from_now) { 2.days.from_now }
  before do
    create_list(:couch, 2, city: "This City")
    create(:couch, city: "That City")
    @couch_1, couch_2, couch_3 = Couch.all[0..2]
    @couch_1.nights << create(:night, date: today)
    @couch_1.nights << create(:night, date: Date.tomorrow)
    couch_2.nights << create(:night, date: today + 10.days)
    couch_3.nights << create(:night, date: today)
    couch_3.nights << create(:night, date: Date.tomorrow)
    @nights_params = { 
      "check_in" => today.to_date_picker_format,
      "check_out" => two_days_from_now.to_date_picker_format,
      "couch_id" => @couch_1.id
    }
  end

  describe ".find" do
    it "returns the nights in a given range for a couch" do
      result   = NightFinder.find(@nights_params)
      in_range = result.pluck(:date).all? { |date| date.between?(today, two_days_from_now) }

      expect(result).to be_an Night::ActiveRecord_Relation
      expect(result.count).to eq 2
      expect(result.pluck(:couch_id).uniq).to eq [@couch_1.id]
      expect(in_range).to be true
    end
  end

  describe "#find_nights" do
    it "returns the nights for a given date range and couch" do
      result   = NightFinder.find(@nights_params)
      right_id = result.pluck(:couch_id).all? { |id| id == @couch_1.id }
      in_range = result.pluck(:date).all? { |date| date.between?(today, two_days_from_now) }

      expect(result).to be_an Night::ActiveRecord_Relation
      expect(result.count).to eq 2
      expect(right_id).to be true
      expect(in_range).to be true
    end
  end
end
