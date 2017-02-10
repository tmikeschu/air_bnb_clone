class ReservationMaker
  def initialize(traveler, nights_params)
    @reservation = Reservation.new(traveler)
    @nights = NightFinder.find(nights_params)
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
    @reservation.save
  end
end
