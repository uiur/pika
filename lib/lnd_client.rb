require 'rpc_services_pb'

class LndClient
  LND_RPC_DIR = '/lnd_0_rpc'

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
      'lnd_0:10009',
      GRPC::Core::ChannelCredentials.new(File.read("#{LND_RPC_DIR}/tls.cert")),
      interceptors: [MacaroonInterceptor.new(macaroon)]
    )
  end

  def self.macaroon
    Digest.hexencode(File.read("#{LND_RPC_DIR}/admin.macaroon"))
  end

  def self.get_info
    shared.get_info(Lnrpc::GetInfoRequest.new)
  end

  def self.wallet_balance
    shared.wallet_balance(Lnrpc::WalletBalanceRequest.new)
  end
end
