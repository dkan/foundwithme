class MessagesController < ApplicationController
  def create
    @message = Message.new(params[:message])
    @recipient = User.find(@message.recipient_id)
    if @message.save
      MessageMailer.contact(@recipient, current_user, @message.body).deliver
      render json: {
        success: "Email sent"
      }, status: 200
    else
      render json: {
        success: "There has been an error sending your email"
      }, status: 200
    end
  end
end
