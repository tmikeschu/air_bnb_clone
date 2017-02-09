class Couch < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zipcode
  belongs_to :host, class_name: "User", foreign_key: :user_id
  has_many :nights

  def self.search(params)
    Couch.joins(:nights).where(city: params["Destination"]).where("nights.date = ?", Date.parse(params["Check In"]))
  end
end
