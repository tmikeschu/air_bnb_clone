class User < ApplicationRecord
  validates :email, :phone_number, uniqueness: :true
  validates :phone_number, presence: :true
  has_secure_password
  has_many :couches
end
