class AddCategoryToProduct < ActiveRecord::Migration[5.0]
  def change
    change_table :products do |t|
      t.remove :category
      t.belongs_to :gallery_category, index: true
    end
  end
end
