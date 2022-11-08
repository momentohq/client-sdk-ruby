require 'jwt'
require 'controlclient_services_pb'
require 'momento/response'

module Momento
  # A simple client for Momento.
  #
  # @example
  #   client = Momento::SimpleCacheClient.new(auth_token: jwt)
  #   response = client.create_cache(cache_name)
  #   case response
  #   when Momento::Response::Success
  #     p "Cache created!"
  #   when Momento::Response::AlreadyExists
  #     p "Cache already exists."
  #   when Momento::Response::InvalidArgument
  #     p "Cache name is invalid."
  #   end
  class SimpleCacheClient
    VERSION = Momento::Client::VERSION
    CONTROL_CLIENT_STUB_CLASS = ControlClient::ScsControl::Stub

    # @param auth_token [String] the JWT for your Momento account
    def initialize(auth_token:)
      @auth_token = auth_token
      load_endpoints_from_token
    end

    # Create a new Momento cache.
    #
    # @param name [String] the name of the cache to create.
    # @return [Momento::Response] the response from Momento.
    def create_cache(name)
      req = ControlClient::CreateCacheRequest.new(cache_name: name)

      begin
        control_stub.create_cache(req)
      rescue GRPC::BadStatus => e
        Momento::Response.wrap_grpc_exception(e)
      else
        return Momento::Response::Success.new
      end
    end

    # Delete an existing Momento cache.
    #
    # @param name [String] the name of the cache to delete.
    # @return [Momento::Response] the response from Momento.
    def delete_cache(name)
      req = ControlClient::DeleteCacheRequest.new(cache_name: name)

      begin
        control_stub.delete_cache(req)
      rescue GRPC::BadStatus => e
        Momento::Response.wrap_grpc_exception(e)
      else
        return Momento::Response::Success.new
      end
    end

    private

    def control_stub
      @control_stub ||= CONTROL_CLIENT_STUB_CLASS.new(@control_endpoint, combined_credentials)
    end

    def combined_credentials
      @combined_credentials ||= make_combined_credentials
    end

    def load_endpoints_from_token
      claim = JWT.decode(@auth_token, nil, false).first

      @control_endpoint = claim["cp"]
      @cache_endpoint = claim["c"]
    end

    def make_combined_credentials
      # :nocov:
      auth_proc = proc do
        { authorization: @auth_token, agent: "ruby:#{VERSION}" }
      end
      # :nocov:

      call_creds = GRPC::Core::CallCredentials.new(auth_proc)

      return GRPC::Core::ChannelCredentials.new.compose(call_creds)
    end
  end
end
