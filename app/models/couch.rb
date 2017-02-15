class Couch < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zipcode
  belongs_to :host, class_name: "User", foreign_key: :user_id
  has_many :nights
  has_many :photos, class_name: "CouchPhoto"
  has_many :reservations, through: :nights

  geocoded_by :street_city_address
  after_validation :geocode

  scope :in_city, -> (city) { where("lower(city) = ?", city.downcase) }

  def self.search(params)
    near(params["Destination"])
    .joins(:nights)
    .merge(
      Night.between_check_in_check_out(to_date(params["Check In"]), to_date(params["Check Out"]))
    )
    .distinct
  end

  def street_city_address
    "#{self.street_address}, #{self.city}"
  end

  def self.available_cities
    Couch.all.pluck(:city).uniq
  end
  
  def available_nights
    self.nights.where(reservation_id: nil).pluck(:date)
  end

  private

    def self.to_date(string)
      Date.strptime(string, "%m/%d/%Y")
    end
end
