require './lib/rpc_services_pb'

class LndClient
  def self.shared
    ENV["GRPC_SSL_CIPHER_SUITES"] = 'HIGH+ECDSA'

    @client = Lnrpc::Lightning::Stub.new('lnd:10009', GRPC::Core::ChannelCredentials.new(File.read('/shared/lnd/tls.cert')))
  end

  def self.metadata
    { macaroon: Digest.hexencode(File.read('/shared/lnd/admin.macaroon')) }
  end

  def self.get_info
    shared.get_info(Lnrpc::GetInfoRequest.new, metadata: metadata)
  end
end
