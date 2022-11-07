require 'jwt'
require 'controlclient_services_pb'
require 'momento/response'

module Momento
  # A simple client for Momento.
  class SimpleCacheClient
    VERSION = Momento::Client::VERSION

    def initialize(auth_token:)
      @auth_token = auth_token
      load_endpoints_from_token

      @control_stub = ControlClient::ScsControl::Stub.new(@control_endpoint, combined_credentials)
    end

    def create_cache(name)
      req = ControlClient::CreateCacheRequest.new(cache_name: name)

      begin
        @control_stub.create_cache(req)
      rescue GRPC::BadStatus => e
        Momento::Response.wrap_grpc_exception(e)
      else
        return Momento::Response::Success.new
      end
    end

    def delete_cache(name)
      req = ControlClient::DeleteCacheRequest.new(cache_name: name)

      begin
        @control_stub.delete_cache(req)
      rescue GRPC::BadStatus => e
        Momento::Response.wrap_grpc_exception(e)
      else
        return Momento::Response::Success.new
      end
    end

    private

    def combined_credentials
      @combined_credentials ||= make_combined_credentials
    end

    def load_endpoints_from_token
      claim = JWT.decode(@auth_token, nil, false).first

      @control_endpoint = claim["cp"]
      @cache_endpoint = claim["c"]
    end

    def make_combined_credentials
      auth_proc = proc do
        { authorization: @auth_token, agent: "ruby:#{VERSION}" }
      end
      call_creds = GRPC::Core::CallCredentials.new(auth_proc)

      return GRPC::Core::ChannelCredentials.new.compose(call_creds)
    end
  end
end
