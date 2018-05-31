class AccountsController < ApplicationController
  before_action :require_account, only: [:me]

  def create
    @account = Account.new(balance: 0)

    if @account.save
      render json: { token: generate_token(@account) }, status: :created
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end

  def me
    render json: { balance: current_account.balance }
  end
end
