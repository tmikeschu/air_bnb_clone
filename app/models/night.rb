class Night < ApplicationRecord
  validates_presence_of :date
  validate :night_cannot_be_in_the_past
  belongs_to :couch
  belongs_to :reservation, optional: true

  scope :all_for_couch, -> (couch) { where(couch: couch) }
  scope :between_check_in_check_out, -> (check_in, check_out) {
    where(date: (Date.parse(check_in))..(Date.parse(check_out) - 1.day))
  }

  def night_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end
end
