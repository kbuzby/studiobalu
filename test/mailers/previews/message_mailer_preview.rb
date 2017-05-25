# Preview all emails at http://localhost:3000/rails/mailers/message_mailer
class MessageMailerPreview < ActionMailer::Preview
  def new_order
    MessageMailer.new_order(Order.first)
  end
end
