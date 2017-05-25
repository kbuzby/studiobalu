class AddPaymentDetails < ActiveRecord::Migration[5.0]
  def change
    change_table :orders do |t|
      t.string :card_type
      t.string :card_number
      t.integer :card_exp_month
      t.integer :card_exp_year
      t.integer :card_cvv2

      t.string :sale_id
    end
  end
end
