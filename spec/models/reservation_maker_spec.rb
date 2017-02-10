require "rails_helper"

RSpec.describe ReservationMaker do
  describe ".create_reservation" do
    xit "creates a reservation" do
      couch = create(:couch)
      couch.nights << create(:night, date: Date.current)
      couch.nights << create(:night, date: Date.tomorrow)
      couch.nights << create(:night, date: Date.tomorrow.tomorrow)
      traveler = create(:user)
      nights_params = {"check_in": Date.current.to_s, "check_out": Date.tomorrow.tomorrow.to_s, "couch_id": couch.id}
      traveler_params = {"user_id": traveler.id}
      ReservationMaker.create_reservation(
        traveler: traveler_params,
        nights: nights_params )
      byebug
    end
  end

  describe "#add_nights" do
    it "adds nights to the reservation" do
      couch = create(:couch)
    end
  end

  describe "#confirm" do
    it "changes status to confirmed" do
    end
  end

  describe "#save" do
    it "saves the reservation" do
    end
  end
end
