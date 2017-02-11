class CouchPhoto < ApplicationRecord
  mount_uploader :image, ImageUploader

  validates_presence_of :title

  belongs_to :couch
end

