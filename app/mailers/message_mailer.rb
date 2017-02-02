class MessageMailer < ApplicationMailer

  default from: "kyle.buzby@gmail.com"
  default to: "kyle.buzby@gmail.com"

  def new_message(message)
    @message = message

    mail(subject: "Message from #{message.name}")

  end

end
