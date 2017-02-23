class Product < ApplicationRecord
  has_many :item_images
  belongs_to :gallery_category, optional: true
end
