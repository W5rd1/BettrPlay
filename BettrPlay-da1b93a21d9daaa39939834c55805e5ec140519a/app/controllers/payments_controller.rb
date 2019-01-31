class PaymentsController < ApplicationController
  def new
  end

  def create
    @deposit = Deposit.find(params[:deposit_id])
    customer = Stripe::Customer.create(
    source: params[:stripeToken],
    email:  params[:stripeEmail]
  )

  charge = Stripe::Charge.create(
    customer:     customer.id,   # You should store this customer id and re-use it.
    amount:       @deposit.amount_cents,
    description:  "deposit for BettrPlay",
    currency:     current_user.balance.currency
  )
  @deposit.update(payment: charge.to_json, state: 'paid')
  current_user.balance_cents += @deposit.amount_cents
  current_user.save
  redirect_to challenges_path

  rescue Stripe::CardError => e
  flash[:alert] = e.message
  redirect_to new_deposit_payment_path(@deposit)
  end

end
