require 'lnd_client'

class WalletsController < ApplicationController
  def show
    wallet_balance = LndClient.wallet_balance

    render json: {
      balance: wallet_balance.total_balance
    }
  end
end
