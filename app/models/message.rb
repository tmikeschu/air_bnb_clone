class Message < ApplicationRecord
  validates_presence_of :content
  belongs_to :reservation
  belongs_to :author, class_name: "User", foreign_key: :user_id
end
