class ReservationMaker
  attr_reader :reservation

  def add_nights_for_traveler(traveler, nights)
    @reservation = Reservation.new(traveler)
    @nights      = NightFinder.find(nights)
    confirm_nights
  end

  def self.create_reservation(traveler: , nights:)
   new.add_nights_for_traveler(traveler, nights)
  end

  private

    def add_nights
      @reservation.nights << @nights
    end

    def confirm
      @reservation.confirmed!
    end

    def confirm_nights
      add_nights
      confirm
      @reservation
    end
end
