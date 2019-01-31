class DepositsController < ApplicationController
  def new
    @deposit = Deposit.new
  end

  def create
    deposit = Deposit.create!(state: 'pending', amount: params[:amount], user: current_user)
    redirect_to new_deposit_payment_path(deposit)
  end

  def update
    @deposit = Deposit.find(params[:deposit_id])
    @deposit.update(strong_params)
  end

  private

  def strong_params
    params.require(:deposit).permit(:state, :payment)
  end
end
