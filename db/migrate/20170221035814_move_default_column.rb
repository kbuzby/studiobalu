class MoveDefaultColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :item_images, :primary
    add_column :products, :primary_image, :integer
  end
end
