class Order < ApplicationRecord
  has_many :products

  def placed?
    return status == 'ordered' || status == 'shipped' || status =='completed'
  end
end
