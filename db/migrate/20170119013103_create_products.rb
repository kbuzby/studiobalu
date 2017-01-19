class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :category
      t.string :description
      t.string :image_path, index: true
      t.decimal :price, scale: 2
      t.boolean :sold
      t.timestamps
    end
  end
end
