require 'rails_helper'

RSpec.describe 'payments', type: :request do

  describe 'POST /payments' do

    context 'without token' do
      it do
        post '/payments'
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'wrong token' do
      it do
        post '/payments', headers: { 'Authorization': "Bearer shit"}
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'valid token' do
      let(:account) { Account.create(balance: 100) }
      before do
        allow(LndClient).to receive(:decode_pay_req) do
          {
            'num_satoshis' => 10
          }
        end

        allow(LndClient).to receive(:pay) { }
      end

      it do
        token = Pika::Token.encode({ id: account.id })
        post '/payments', params: { payment_request: 'foobar' }, headers: { 'Authorization': "Bearer #{token}"}
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
