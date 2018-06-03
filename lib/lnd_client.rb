require 'rpc_services_pb'

class LndClient
  class MacaroonInterceptor < GRPC::ClientInterceptor
    attr_reader :macaroon

    def initialize(macaroon)
      @macaroon = macaroon
      super
    end

    def request_response(request:, call:, method:, metadata:)
      metadata.merge!(macaroon: macaroon)
      yield
    end
  end

  def self.shared
    ENV["GRPC_SSL_CIPHER_SUITES"] = 'HIGH+ECDSA'

    @client ||= Lnrpc::Lightning::Stub.new(
      "#{lnd_host}:10009",
      GRPC::Core::ChannelCredentials.new(File.read(rpc_cert)),
      interceptors: [MacaroonInterceptor.new(macaroon)]
    )
  end

  def self.macaroon
    Digest.hexencode(File.read(macaroon_path))
  end

  def self.get_info
    shared.get_info(Lnrpc::GetInfoRequest.new)
  end

  def self.wallet_balance
    shared.wallet_balance(Lnrpc::WalletBalanceRequest.new)
  end

  def self.decode_pay_req(pay_req)
    shared.decode_pay_req(Lnrpc::PayReqString.new(pay_req: pay_req))
  end

  def self.pay(pay_req)
    request = Lnrpc::SendRequest.new(
      payment_request: pay_req
    )

    shared.send_payment_sync(request)
  end

  private

  def self.rpc_cert
    ENV.fetch('LND_RPC_CERT')
  end

  def self.lnd_host
    ENV.fetch('LND_HOST') { 'lnd' }
  end

  def self.macaroon_path
    ENV.fetch('LND_MACAROON')
  end
end
