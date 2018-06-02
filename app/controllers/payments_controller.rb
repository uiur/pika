require 'lnd_client'

class PaymentsController < ApplicationController
  before_action :require_account

  def create
    data = LndClient.decode_pay_req(params[:payment_request])
    amount = data['num_satoshis']
    if current_account.balance < amount
      return render json: { error: 'balance is not enough' }, status: :unprocessable_entity
    end

    res = nil
    ActiveRecord::Base.transaction do
      # TODO: atomic update
      current_account.update!(balance: current_account.balance - amount)
      res = LndClient.pay(params[:payment_request])
    end

    # error: res.payment_error
    render json: {}, status: :ok
  end
end
