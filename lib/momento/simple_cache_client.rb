require 'jwt'
require 'momento/cacheclient_services_pb'
require 'momento/controlclient_services_pb'
require 'momento/response'

module Momento
  # A simple client for Momento.
  #
  # @example
  #   client = Momento::SimpleCacheClient.new(
  #     auth_token: jwt,
  #     default_ttl: 10_000
  #   )
  #
  #   response = client.get("my_cache", "key")
  #   case response
  #   when Momento::Response::Get::Hit
  #     p response
  #   when Momento::Response::Get::Miss
  #     p client.set(cache_name, key, "default")
  #   when Momento::Response::Error
  #     p "The front fell off."
  #   end
  class SimpleCacheClient
    VERSION = Momento::VERSION
    CACHE_CLIENT_STUB_CLASS = CacheClient::Scs::Stub
    CONTROL_CLIENT_STUB_CLASS = ControlClient::ScsControl::Stub

    # The default time to live, in milliseconds.
    attr_accessor :default_ttl

    # @param auth_token [String] the JWT for your Momento account
    # @param default_ttl [Integer]
    def initialize(auth_token:, default_ttl:)
      @auth_token = auth_token
      @default_ttl = default_ttl
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

    def cache_stub
      @cache_stub ||= CACHE_CLIENT_STUB_CLASS.new(@cache_endpoint, combined_credentials)
    end

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
