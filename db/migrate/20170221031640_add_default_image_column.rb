class AddDefaultImageColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :item_images, :primary, :boolean, default: false
    ItemImage.find_each do |i|
      i.primary = true
      i.save!
    end
  end
end
