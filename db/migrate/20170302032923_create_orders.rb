class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :email
      t.string :status
      t.date :order_date
      t.string :payment_id
      t.decimal :subtotal, precision: 8, scale: 2
      t.decimal :tax, precision: 8, scale: 2
      t.decimal :shipping, precision: 8, scale: 2
      t.decimal :total, precision: 8, scale: 2
      t.timestamps
    end

    add_column :products, :order_id, :integer, index: true
    remove_column :products, :sold
  end
end
