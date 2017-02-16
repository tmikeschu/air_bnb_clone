class Profile < ApplicationRecord
  validates_presence_of :user
  belongs_to :user

  def self.user
    User.find(self.user_id)
  end
end
