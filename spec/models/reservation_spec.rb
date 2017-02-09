require 'rails_helper'

describe Reservation do
  describe "validations" do
    it { is_expected.to validate_presence_of(:status) }
  end

  describe "relationships" do
    it { is_expected.to belong_to(:traveler).class_name("User") }
    it { is_expected.to have_many(:nights) }
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
end
