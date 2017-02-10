require "rails_helper"

RSpec.describe NightFinder do
  before do
    couch = create(:couch)
    couch.nights << create(:night, date: Date.current)
    couch.nights << create(:night, date: Date.tomorrow)
    couch.nights << create(:night, date: Date.tomorrow.tomorrow)
    @nights_params = { "check_in" => Date.current.to_s, "check_out" => Date.tomorrow.tomorrow.to_s, "couch_id" => couch.id }
    @maker = NightFinder.new(@nights_params)
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
      result = NightFinder.new(@nights_params).find_nights
      expect(result).to be_an Night::ActiveRecord_Relation
      expect(result.count).to eq 2
    end
  end
end
