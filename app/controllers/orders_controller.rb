class OrdersController < ApplicationController
  skip_before_action :require_login

  require  'paypal-sdk-rest'
  include PayPal::SDK::REST

  def create
  end

  def update

    @order = ::Order.find(params[:id])

    #pull out the parameters here to be used

    @order.billing_first_name = params[:order][:billing_first_name]
    @order.billing_last_name = params[:order][:billing_last_name]
    @order.email = params[:order][:email]
    @order.billing_address1 = params[:order][:billing_address1]
    @order.billing_address2 = params[:order][:billing_address2]
    @order.billing_city = params[:order][:billing_city]
    @order.billing_state = params[:order][:billing_state]
    @order.billing_zip = params[:order][:billing_zip]

    @order.shipping_name = params[:order][:shipping_name]
    @order.shipping_address1 = params[:order][:shipping_address1]
    @order.shipping_address2 = params[:order][:shipping_address2]
    @order.shipping_city = params[:order][:shipping_city]
    @order.shipping_state = params[:order][:shipping_state]
    @order.shipping_zip = params[:order][:shipping_zip]

    @order.card_type = params[:order][:card_type]
    @order.card_number = params[:order][:card_number]
    @order.card_exp_month = params[:order][:card_exp_month]
    @order.card_exp_year = params[:order][:card_exp_year]
    @order.card_cvv2 = params[:order][:card_cvv2]

    @order.tax = @order.subtotal * 0.07
    @order.shipping = 10.00

    @order.total = @order.subtotal + @order.tax + @order.shipping

    if @order.save!
      session[:order_accepted] = true

    else
      flash[:error] = 'There was an error saving your billing info'
    end
    redirect_to url_for(controller: 'orders', action: 'show')

  end


  def show
    if !session[:order_id].nil?
      @order = ::Order.find(session[:order_id])

      if !@order.nil?

        @orderItems = Product.where(order_id: @order.id)

        if @order.status == 'ordered'
          @cartTitle = 'Thanks for your order!'
          @orderCompleted = true
        else
          #else the order hasn't been placed yet
          @cartTitle = 'Your Cart'
          @orderCompleted = false

          #update order costs here
          @order.tax = @order.subtotal * 0.07
          @order.shipping = 10
          @order.total = @order.subtotal + @order.tax + @order.shipping
          @order.save!

          @transactions = {
            transactions: [{
              item_list: {
                items: create_item_array(@order.id)
              },
              amount: {
                total: '%.2f' % @order.total,
                currency: 'USD',
                details: {
                  subtotal: '%.2f' % @order.subtotal,
                  tax: '%.2f' % @order.tax,
                  shipping: '%.2f' % @order.shipping
                }
              },
              description: 'Order from Studio Balu Designs'
          }]}.to_json.html_safe
        end

      else
        @cartTitle = 'Cart Empty'
      end
    end

  end

  def payment_approved
    logger.info params
    @order = ::Order.find(params[:id])

    payment = params[:payment]

    #save paypal resource ids
    @order.payment_id = payment[:id]
    @order.sale_id = payment[:transactions][0][:related_resources][0][:sale][:id]

    #save ordering persons info
    payer = payment[:payer][:payer_info]
    @order.email = payer[:email]
    @order.name = payer[:first_name]+' '+payer[:last_name]
    @order.shipping_name = payer[:shipping_address][:recipient_name]
    @order.shipping_address1 = payer[:shipping_address][:line1]
    @order.shipping_address2 = payer[:shipping_address][:line2]
    @order.shipping_city = payer[:shipping_address][:city]
    @order.shipping_state = payer[:shipping_address][:state]
    @order.shipping_zip = payer[:shipping_address][:postal_code]

    @order.transaction_fee = payment[:transactions][0][:related_resources][0][:sale][:transaction_fee][:value]

    #update order status
    @order.status = 'ordered'

    @order.save!

    #need to send email to auntjen that an order was placed
    MessageMailer.new_order(@order).deliver
  end

  def destroy
  end


  private
  def create_item_array(order_id)
    orderItems = Product.where(order_id: order_id)

    item_array = []

    for item in orderItems
      item_array.push({name: item.name,
      sku: item.id,
      price: item.price,
      currency: 'USD',
      quantity: 1})
    end

    return item_array
  end


end
