class AccountsController < ApplicationController
  def create
    @account = Account.new(balance: 0)

    if @account.save
      render json: { token: generate_token(@account) }, status: :created
    else
      render json: @account.errors, status: :unprocessable_entity
    end
  end
end
