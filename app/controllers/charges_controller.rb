class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :plan => "normal",
      :card  => params[:stripe_token]
    )

    current_user.paid = true
    current_user.save!

    render json: {
      success: "You have subscribed successfully"
    }, status: 200
  rescue Stripe::CardError => e
    current_user.paid = false
    current_user.save
  
    render json: {
      error: e.message
    }, status: 200
  end
end
