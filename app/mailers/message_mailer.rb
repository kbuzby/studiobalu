class MessageMailer < ApplicationMailer

  default from: "studiobaludesigns@comcast.net"
  default to: "studiobaludesigns@comcast.net"

  def new_message(message)
    @message = message

    mail(subject: "Message from #{message.name}")

  end

end
