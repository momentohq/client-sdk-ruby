require 'jwt'

module Momento
  # A simple client for Momento.
  class SimpleCacheClient
    attr_accessor :control_endpoint, :cache_endpoint

    def initialize(auth_token:)
      load_endpoints_from_token(auth_token: auth_token)
    end

    private

    def load_endpoints_from_token(auth_token:)
      claim = JWT.decode(auth_token, nil, false).first

      self.control_endpoint = claim["cp"]
      self.cache_endpoint = claim["c"]
    end
  end
end
