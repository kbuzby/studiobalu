module CurrentOrder
  extend ActiveSupport::Concern

  private

  def set_order
    @order = Order.find(:order_id)
  rescue ActiveRecord::RecordNotFound
    @order = Order.create!
    session[:order_id] = @order.id
  end
  
end
