require 'pika/token'

class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protected
  def generate_token(account)
    Pika::Token.encode({
      id: account.id
    })
  end

  def require_account
    authenticate_or_request_with_http_token do |token, options|
      decoded_token = Pika::Token.decode(token)
      next unless decoded_token

      payload, header = decoded_token

      @current_account = Account.find_by(id: payload['id'])
      @current_account.present?
    end
  end

  def current_account
    @current_account
  end
end
