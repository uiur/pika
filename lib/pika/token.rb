module Pika
  class Token
    def self.encode(payload)
      JWT.encode(
        payload,
        Rails.application.secrets.secret_key_base,
        'HS512'
      )
    end

    def self.decode(token)
      JWT.decode(
        token,
        Rails.application.secrets.secret_key_base,
        true,
        { algorithm: 'HS512' }
      )
    rescue JWT::DecodeError
      nil
    end
  end
end
