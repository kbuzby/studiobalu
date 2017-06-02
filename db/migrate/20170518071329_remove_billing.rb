class RemoveBilling < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :billing_first_name
    remove_column :orders, :billing_last_name
    remove_column :orders, :billing_city
    remove_column :orders, :billing_address1
    remove_column :orders, :billing_address2
    remove_column :orders, :billing_state
    remove_column :orders, :billing_zip
    remove_column :orders, :card_type
    remove_column :orders, :card_number
    remove_column :orders, :card_exp_month
    remove_column :orders, :card_exp_year
    remove_column :orders, :card_cvv2
  end
end
