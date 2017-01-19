class Product < ApplicationRecord
  mount_uploader :image_path, PhotoUploader
end
