class OrderUpdates < ActiveRecord::Migration[5.0]
  def change
    change_table :orders do |t|
      t.string :name
      t.decimal :transaction_fee, precision: 8, scale: 2
    end
  end
end
