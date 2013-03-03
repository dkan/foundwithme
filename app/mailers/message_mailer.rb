class MessageMailer < ActionMailer::Base
  default from: "\"Found With Me\" <contact@foundwithme.co>"

  def contact(recipient, sender, body)
    @recipient = recipient
    @sender = sender
    @body = body
    mail(to: @recipient.email,
         subject: "#{@sender.first_name} #{@sender.last_name} wants to contact you.")
  end
end
