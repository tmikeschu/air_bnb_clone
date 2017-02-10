class ReservationMaker
  attr_reader :reservation

  def initialize(traveler, nights)
    @reservation = Reservation.new(traveler)
    @nights      = NightFinder.find(nights)
  end

  def self.create_reservation(traveler: , nights:)
    ReservationMaker.new(traveler, nights).add_nights
  end

  def add_nights
    @reservation.nights << @nights
    confirm
  end

  def confirm
    @reservation.confirmed!
    save
  end

  def save
    @reservation.save && @reservation
  end
end
