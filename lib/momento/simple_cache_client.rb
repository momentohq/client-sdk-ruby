require 'jwt'
require_relative 'cacheclient_services_pb'
require_relative 'controlclient_services_pb'
require_relative 'response'

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
  #   if response.hit?
  #     puts "We got #{response}"
  #   elsif response.miss?
  #     puts "It's not in the cache"
  #   elsif response.error?
  #     puts "The front fell off."
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

    # Get a value in a cache.
    #
    # Momento only stores bytes; the returned value will be encoded as ASCII-8BIT.
    #
    # @param cache_name [String]
    # @param key [String] must only contain ASCII characters
    # @return [Momento::GetResponse]
    def get(cache_name, key)
      builder = GetResponseBuilder.new(context: { cache_name: cache_name, key: key })
      return builder.from_block do
        cache_stub.get(
          CacheClient::GetRequest.new(cache_key: to_bytes(key)),
          metadata: { cache: cache_name }
        )
      end
    end

    # Set a value in a cache.
    #
    # If ttl is not set, it will use the default_ttl.
    #
    # @param cache_name [String]
    # @param key [String] must only contain ASCII characters
    # @param value [String] the value to cache
    # @param ttl [Integer] time to live, in milliseconds.
    # @return [Momento::SetResponse]
    def set(cache_name, key, value, ttl: default_ttl)
      return SetResponse.from_block do
        req = CacheClient::SetRequest.new(
          cache_key: to_bytes(key),
          cache_body: to_bytes(value),
          ttl_milliseconds: ttl
        )

        cache_stub.set(req, metadata: { cache: cache_name })
      end
    end

    # Delete a key in a cache.
    #
    # @param cache_name [String]
    # @param key [String] must only contain ASCII characters
    # @return [Momento::DeleteResponse]
    def delete(cache_name, key)
      return DeleteResponse.from_block do
        cache_stub.delete(
          CacheClient::DeleteRequest.new(cache_key: to_bytes(key)),
          metadata: { cache: cache_name }
        )
      end
    end

    # Create a new Momento cache.
    #
    # @param name [String] the name of the cache to create.
    # @return [Momento::CreateCacheResponse] the response from Momento.
    def create_cache(name)
      builder = CreateCacheResponseBuilder.new(context: { cache_name: name })
      return builder.from_block do
        control_stub.create_cache(
          ControlClient::CreateCacheRequest.new(cache_name: name)
        )
      end
    end

    # Delete an existing Momento cache.
    #
    # @param name [String] the name of the cache to delete.
    # @return [Momento::DeleteCacheResponse] the response from Momento.
    def delete_cache(name)
      builder = DeleteCacheResponseBuilder.new(context: { cache_name: name })
      return builder.from_block do
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
    # @return [Momento::ListCachesResponse]
    def list_caches(next_token: "")
      return ListCachesResponse.from_block do
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

    # Ruby uses String for bytes. GRPC wants a String encoded as ASCII.
    # GRPC will re-encode a String, but treats it as characters; GRPC will
    # raise if you pass a String with non-ASCII characters.
    # So we do the re-encoding ourselves in a way that treats the String as
    # bytes and will not raise. The data is not changed.
    #
    # A duplicate String is returned, but since Ruby is copy-on-write it
    # does not copy the data.
    #
    # @param string [String] the string to make safe for GRPC bytes
    # @return [String] a duplicate safe to use as GRPC bytes
    def to_bytes(string)
      # dup in case the value is frozen and to avoid changing the value's encoding
      # for the caller.
      return string.dup.force_encoding(Encoding::ASCII_8BIT)
    end
  end
end
