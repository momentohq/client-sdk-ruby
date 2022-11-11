require 'jwt'
require 'momento/controlclient_services_pb'
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
    VERSION = Momento::VERSION
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
      return Response::CreateCache.from_block do
        control_stub.create_cache(
          ControlClient::CreateCacheRequest.new(cache_name: name)
        )
      end
    end

    # Delete an existing Momento cache.
    #
    # @param name [String] the name of the cache to delete.
    # @return [Momento::Response] the response from Momento.
    def delete_cache(name)
      return Response::DeleteCache.from_block do
        control_stub.delete_cache(
          ControlClient::DeleteCacheRequest.new(cache_name: name)
        )
      end
    end

    # List a page of your caches.
    #
    # The next_token indicates which page to fetch.
    # If nil or "" it will fetch the first page. Default is to fetch the first page.
    #
    # @params next_token [String, nil] the token of the page to request
    # @return [Momento::Response::ListCaches]
    def list_caches(next_token: "")
      return Response::ListCaches.from_block do
        control_stub.list_caches(
          ControlClient::ListCachesRequest.new(next_token: next_token)
        )
      end
    end

    # Lists the names of all your caches.
    #
    # @return [Enumerator::Lazy<String>] the cache names
    # @raise [GRPC::BadStatus]
    # rubocop:disable Metrics/MethodLength
    def caches
      Enumerator.new do |yielder|
        next_token = ""

        loop do
          response = list_caches(next_token: next_token)
          raise response.grpc_exception if response.is_a? Momento::Response::Error

          response.cache_names.each do |name|
            yielder << name
          end

          break if response.next_token == ''

          next_token = response.next_token
        end
      end.lazy
    end
    # rubocop:enable Metrics/MethodLength

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
