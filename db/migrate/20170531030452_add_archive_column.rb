class AddArchiveColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :archived, :boolean, index: true, default: false
  end
end
