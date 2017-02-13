require "rails_helper"
include ModelHelpers

RSpec.describe ReservationMaker do
  before do
    couch = create(:couch)
    couch.nights << create(:night, date: Date.current)
    couch.nights << create(:night, date: Date.tomorrow)
    couch.nights << create(:night, date: Date.tomorrow.tomorrow)
    @traveler = create(:user)
    @nights_params = { 
      "check_in" => Date.current.to_date_picker_format,
      "check_out" => Date.tomorrow.tomorrow.to_date_picker_format,
      "couch_id" => couch.id
    }
    @traveler_params = { "user_id" => @traveler.id }
    @maker = ReservationMaker.new
  end

  describe ".create_reservation" do
    it "creates a reservation" do
      expect(@traveler.reservations.count).to eq 0
      ReservationMaker.create_reservation(
        traveler: @traveler_params,
        nights: @nights_params
      )
      expect(@traveler.reservations.count).to eq 1
      expect(@traveler.reservations.first.nights.count).to eq 2
    end
  end

  describe "#add_nights_for_traveler()" do
    it "adds nights to the reservation" do
      expect(@traveler.reservations.count).to eq 0
      @maker.add_nights_for_traveler(@traveler_params, @nights_params)
      expect(@traveler.reservations.count).to eq 1
      expect(@traveler.reservations.first.nights.count).to eq 2
    end
  end
end
