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
    address1 = order[:billing_address1]
    address2 = order[:billing_address2]
    city = order[:billing_city]
    state = order[:billing_state]
    zip = order[:billing_zip]

    shipping_name = order[:shipping_name]
    address1 = order[:shipping_address1]
    address2 = order[:shipping_address2]
    city = order[:shipping_city]
    state = order[:shipping_state]
    zip = order[:shipping_zip]

    if @order.update_attributes({
      billing_first_name: first_name,
      billing_last_name: last_name,
      email: email,
      status: 'checking_out',
      billing_address1: address1,
      billing_address2: address2,
      billing_city: city,
      billing_state: state,
      billing_zip: zip,
      shipping_name: shipping_name,
      shipping_address1: address1,
      shipping_address2: address2,
      shipping_city: city,
      shipping_state: state,
      shipping_zip: zip
      })

      session[:order_id_addresses_accepted] = true

    else
      flash[:error] = 'There was an error saving your billing info.'
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


end
