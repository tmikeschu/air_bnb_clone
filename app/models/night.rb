class Night < ApplicationRecord
  validates_presence_of :date
  belongs_to :couch
  belongs_to :reservation

  scope :all_for_couch, -> (couch) { where(couch: couch) }
  scope :between_check_in_check_out, -> (check_in, check_out) {
    where(date: (Date.parse(check_in))..(Date.parse(check_out) - 1.day))
  }
end
