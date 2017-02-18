class CreateItemImages < ActiveRecord::Migration[5.0]
  def change
    create_table :item_images do |t|
      t.string :image_path
      t.integer :product_id, index: true
      t.timestamps
    end
  end
end
