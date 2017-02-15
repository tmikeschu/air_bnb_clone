require 'rails_helper'

describe Reservation do
  describe "validations" do
    it { is_expected.to validate_presence_of(:status) }
  end

  describe "relationships" do
    it { is_expected.to belong_to(:traveler).class_name("User") }
    it { is_expected.to have_many(:nights) }
    it { is_expected.to have_many(:couches).through(:nights) }
    it { is_expected.to have_many(:messages) }
  end

  describe ".host_reservations" do
    let!(:host) { create(:user) }
    let!(:traveler) { create(:user) }
    let!(:couch) { create(:couch, host: host) }
    let!(:reservation_1) { create(:reservation, traveler: traveler) }
    let!(:reservation_2) { create(:reservation, traveler: traveler) }
    let!(:night_1) { create(:night,
                            reservation: reservation_2,
                            couch: couch,
                            date: (Date.current)) }
    let!(:night_2) { create(:night,
                            reservation: reservation_1,
                            couch: couch,
                            date: (Date.current + 1.day)) }

    it "returns the *host* reservations for the given user" do
      expect(Reservation.host_reservations(host)).to match_array [reservation_1, reservation_2]
    end
  end

  describe "#status" do
    let!(:reservation) { create(:reservation) }

    it "defaults to pending" do
      expect(reservation.status).to eq "pending"
      expect(reservation.pending?).to be true
    end

    it "can be set to confirmed" do
      reservation.confirmed!

      expect(reservation.status).to eq "confirmed"
      expect(reservation.confirmed?).to be true
    end

    it "can be set to canceled" do
      reservation.canceled!

      expect(reservation.status).to eq "canceled"
      expect(reservation.canceled?).to be true
    end
  end

  describe "#couch" do
    let!(:reservation) { create(:reservation) }
    let!(:couch) { create(:couch) }
    let!(:night) { create(:night, reservation: reservation, couch: couch) }

    scenario "returns the couch for the reservation" do
      expect(reservation.couch.name).to eq couch.name
    end
  end

  describe "#couch_name" do
    it "returns the name of the couch" do
      reservation = create(:reservation_with_couch)

      expect(reservation.couch_name).to eq reservation.couch.name
    end
  end

  describe "#check_in" do
    it "returns the first night of the reservation by date" do
      reservation = create(:reservation_with_couch)
      check_in_night = reservation.nights.first.date
      reservation.nights << create(:night, date: check_in_night.tomorrow)

      expect(reservation.check_in).to eq check_in_night
    end
  end

  describe "#check_out" do
    it "returns the first night of the reservation by date" do
      reservation = create(:reservation_with_couch)
      check_out_night = reservation.nights.first.date.tomorrow
      reservation.nights << create(:night, date: check_out_night)

      expect(reservation.check_out).to eq check_out_night
    end
  end

  context "host methods" do
    let!(:host) { create(:user, first_name: "Holly Host") }
    let!(:couch) { create(:couch, name: "Sassy Sofa") }
    let!(:night) { create(:night) }
    let!(:reservation) { create(:reservation, status: "confirmed") }
    before do
      host.couches << couch
      couch.nights << night
      reservation.nights << night
    end

    describe "#host" do
      it "returns the host for the reservation" do
        expect(reservation.host.first_name).to eq "Holly Host"
      end
    end

    describe "#host_first_name" do
      it "returns the host's first name for the reservation" do
        expect(reservation.host_first_name).to eq "Holly Host"
      end
    end
  end

  describe "#traveler_first_name" do
    let!(:traveler) { create(:user, first_name: "Timmy Traveler") }
    let!(:reservation) { create(:reservation, traveler: traveler, status: "confirmed") }

    it "returns the traveler's first name for the reservation" do
      expect(reservation.traveler_first_name).to eq "Timmy Traveler"
    end
  end
end
