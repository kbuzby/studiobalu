class MoveImagePath < ActiveRecord::Migration[5.0]
  def change
    execute ("INSERT INTO item_images (product_id, image_path, created_at, updated_at) SELECT id, image_path, created_at, updated_at FROM products")
    remove_column :products, :image_path
  end
end
