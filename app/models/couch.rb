class Couch < ApplicationRecord
  validates_presence_of :name, :street_address, :city, :state, :zipcode
  belongs_to :user
end
