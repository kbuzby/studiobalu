class MessageMailer < ApplicationMailer

  default from: "studiobaludesigns@comcast.net"
  default to: "studiobaludesigns@comcast.net"

  def new_message(message)
    @message = message

    mail(subject: "Message from #{message.name}")

  end

  def new_order(order)
    @order = order
    @orderItems = Product.where(order_id: @order.id)
    mail(subject: "New Order Placed!")
  end

end
