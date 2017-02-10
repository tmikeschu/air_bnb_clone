require "rails_helper"

RSpec.describe ReservationMaker do
  before do
    couch = create(:couch)
    couch.nights << create(:night, date: Date.current)
    couch.nights << create(:night, date: Date.tomorrow)
    couch.nights << create(:night, date: Date.tomorrow.tomorrow)
    @traveler = create(:user)
    @nights_params = { "check_in" => Date.current.to_s, "check_out" => Date.tomorrow.tomorrow.to_s, "couch_id" => couch.id }
    @traveler_params = { "user_id" => @traveler.id }
    @maker = ReservationMaker.new(@traveler_params, @nights_params)
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

  describe "#add_nights" do
    it "adds nights to the reservation" do
      expect(@traveler.reservations.count).to eq 0
      @maker.add_nights
      expect(@traveler.reservations.count).to eq 1
      expect(@traveler.reservations.first.nights.count).to eq 2
    end
  end

  describe "#confirm" do
    it "changes status to confirmed" do
      expect(@maker.reservation.status).to_not eq "confirmed"

      @maker.confirm
      expect(@maker.reservation.status).to eq "confirmed"
    end
  end
end
