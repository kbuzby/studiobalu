class Order < ApplicationRecord
  has_many :products
  attr_accessor :shipping_same_as_billing, :card_type, :card_number, :card_exp_month, :card_exp_year, :card_cvv2
end
