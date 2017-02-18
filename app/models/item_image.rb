class ItemImage < ApplicationRecord
  mount_uploader :image_path, PhotoUploader
end
