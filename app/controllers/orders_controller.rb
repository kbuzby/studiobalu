class OrdersController < ApplicationController
  skip_before_action :require_login

  def create
  end

  def update_addresses

    @order = Order.find(params[:id])

    #pull out the parameters here to be used
    order = params[:order]

    first_name = order[:billing_first_name]
    last_name = order[:billing_last_name]
    email = order[:email]
    billing_address1 = order[:billing_address1]
    billing_address2 = order[:billing_address2]
    billing_city = order[:billing_city]
    billing_state = order[:billing_state]
    billing_zip = order[:billing_zip]

    shipping_name = order[:shipping_name]
    shipping_address1 = order[:shipping_address1]
    shipping_address2 = order[:shipping_address2]
    shipping_city = order[:shipping_city]
    shipping_state = order[:shipping_state]
    shipping_zip = order[:shipping_zip]

    if @order.update_attributes({
      billing_first_name: first_name,
      billing_last_name: last_name,
      email: email,
      status: 'checking_out',
      billing_address1: billing_address1,
      billing_address2: billing_address2,
      billing_city: billing_city,
      billing_state: billing_state,
      billing_zip: billing_zip,
      shipping_name: shipping_name,
      shipping_address1: shipping_address1,
      shipping_address2: shipping_address2,
      shipping_city: shipping_city,
      shipping_state: shipping_state,
      shipping_zip: shipping_zip
      })

      session[:order_id_addresses_accepted] = true

    else
      flash[:error] = 'There was an error saving your billing info'
    end
    redirect_to url_for(controller: 'orders', action: 'show')

  end


  def show

    if !session[:order_id].nil?
      @order = Order.find(session[:order_id])
      @orderItems = Product.where(order_id: @order.id)
      @subtotal = @orderItems.map(&:price).reduce(:+)
    end

  end

  def destroy
  end

  def submit_payment
  end

  def cancel
    @order = Order.find(params[:id])
    if @order.update_attributes({status: 'cancelled'})
      session[:order_id_addresses_accepted] = false
    else
      flash[:error] = 'There was a problem cancelling your order'
    end
    redirect_to url_for(controller: 'orders', action: 'show')
  end


end
