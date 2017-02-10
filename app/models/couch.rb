class Couch < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zipcode
  belongs_to :host, class_name: "User", foreign_key: :user_id
  has_many :nights
  has_many :reservations, through: :nights

  scope :in_city, -> (city) { where(city: city) }

  def self.search(params)
    Couch.joins(:nights)
      .in_city(params["Destination"])
      .merge(
        Night.between_check_in_check_out(params["Check In"], params["Check Out"])
      )
      .distinct
  end
end
