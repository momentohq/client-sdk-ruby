require 'jwt'
require 'cacheclient_services_pb'

module Momento
  # A simple client for Momento.
  class SimpleCacheClient
    attr_accessor :auth_token, :control_endpoint, :cache_endpoint, :cache_stub

    def initialize(auth_token:)
      self.auth_token = auth_token
      load_endpoints_from_token

      channel_creds = GRPC::Core::ChannelCredentials.new
      auth_proc = proc do
        { authorization: auth_token }
      end
      call_creds = GRPC::Core::CallCredentials.new(auth_proc)
      combined_creds = channel_creds.compose(call_creds)
      self.cache_stub = CacheClient::Scs::Stub.new(cache_endpoint, combined_creds)
    end

    private

    def load_endpoints_from_token
      claim = JWT.decode(auth_token, nil, false).first

      self.control_endpoint = claim["cp"]
      self.cache_endpoint = claim["c"]
    end
  end
end
