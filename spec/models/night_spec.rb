require 'rails_helper'

describe Night do
  describe "validations" do
    it { is_expected.to validate_presence_of(:date) }
  end

  describe "relationships" do
    it { is_expected.to belong_to(:reservation) }
    it { is_expected.to belong_to(:couch) }
  end

  describe ".all_for_couch" do
    let!(:couch_1) { create(:couch, city: "Jamestown") }
    let!(:couch_2) { create(:couch, city: "Newport") }

    it "returns only the nights for the given couch" do
      couch_1.nights << create_list(:night, 5, couch: couch_1)
      couch_2.nights << create_list(:night, 6, couch: couch_2)

      expect(Night.all_for_couch(couch_1.id).count).to eq 5
      expect(Night.all_for_couch(couch_1.id)).to match_array couch_1.nights
    end
  end

  describe ".between_check_in_check_out" do
    it "returns all nights between the check in and check out but not including the check out" do
      today = Date.current
      check_out_day = today + 5.days
      3.times { |n| create(:night, date: today + n) }
      4.times { |n| create(:night, date: today + 4.days + n) }

      expect(Night.between_check_in_check_out(today.to_s, check_out_day.to_s).count).to eq 4
    end
  end
end
