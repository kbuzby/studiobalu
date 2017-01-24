class Product < ApplicationRecord
  mount_uploader :image_path, PhotoUploader
  belongs_to :gallery_category, optional: true
end
