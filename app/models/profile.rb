class Profile < ApplicationRecord
  validates_presence_of :user
  belongs_to :user

  def user_name
    "#{user.first_name.capitalize} #{user.last_name[0]}."
  end
end
