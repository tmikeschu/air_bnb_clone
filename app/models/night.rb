class Night < ApplicationRecord
  validates_presence_of :date
  belongs_to :couch
  belongs_to :reservation
end
