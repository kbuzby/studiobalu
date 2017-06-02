class AddAddressColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :name
    change_table :orders do |t|
      t.string :billing_first_name
      t.string :billing_last_name
      t.string :billing_address1
      t.string :billing_address2
      t.string :billing_city
      t.string :billing_state
      t.integer :billing_zip

      t.string :shipping_name
      t.string :shipping_address1
      t.string :shipping_address2
      t.string :shipping_city
      t.string :shipping_state
      t.integer :shipping_zip
    end
  end
end
