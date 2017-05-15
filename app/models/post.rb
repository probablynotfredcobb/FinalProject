class Post < ApplicationRecord
  belongs_to :user
  validates_presence_of :phone_number, :title, :description, :location
  mount_uploader :image, ImageUploader
end
