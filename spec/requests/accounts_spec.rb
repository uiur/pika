require 'rails_helper'

RSpec.describe 'accounts', type: :request do
  context 'index' do
    it do
      post '/accounts'

      expect(response).to have_http_status(:created)
      expect(response.body).to be_json_including({
        token: String
      })
    end
  end

  context 'get' do
    let(:account) { Account.create(balance: 100) }
    let(:token) { Pika::Token.encode({ id: account.id }) }

    it do
      get '/accounts/me', headers: { 'Authorization' => "Bearer #{token}"}

      expect(response).to have_http_status(:ok)
      expect(response.body).to be_json_including({
        balance: account.balance
      })
    end
  end
end
