require "rails_helper"
include ModelHelpers

RSpec.describe NightFinder do
  before do
    couch = create(:couch)
    couch.nights << create(:night, date: Date.current)
    couch.nights << create(:night, date: Date.tomorrow)
    couch.nights << create(:night, date: Date.tomorrow.tomorrow)
    @nights_params = { 
      "check_in" => Date.current.to_date_picker_format,
      "check_out" => Date.tomorrow.tomorrow.to_date_picker_format,
      "couch_id" => couch.id
    }
  end

  describe ".find" do
    it "returns the nights in a given range for a couch" do
      result = NightFinder.find(@nights_params)
      expect(result).to be_an Night::ActiveRecord_Relation
      expect(result.count).to eq 2
    end
  end

  describe "#find_nights" do
    it "returns the nights for a given date range and couch" do
      result = NightFinder.new.find_nights(@nights_params)
      expect(result).to be_an Night::ActiveRecord_Relation
      expect(result.count).to eq 2
    end
  end
end
