class MessageMailer < ApplicationMailer

  default from: "greenwave423@gmail.com"
  default to: "greenwave423@gmail.com"

  def new_message(message)
    @message = message

    mail(subject: "Message from #{message.name}")

  end

end
