require 'jwt'
require_relative 'cacheclient_services_pb'
require_relative 'controlclient_services_pb'
require_relative 'response'
require_relative 'ttl'
require_relative 'exceptions'

module Momento
  # A simple client for Momento.
  #
  # @example
  #
  #   token = ...your Momento JWT...
  #   client = Momento::SimpleCacheClient.new(
  #     auth_token: token,
  #     default_ttl: 100 # 100 seconds
  #   )
  #
  #   response = client.create_cache("my_cache")
  #   if response.error?
  #     puts response.error
  #     raise response.error
  #   end
  #
  #   response = client.get("my_cache", "key")
  #   if response.hit?
  #     puts "We got #{response.value_string}"
  #   elsif response.miss?
  #     puts "It's not in the cache"
  #   elsif response.error?
  #     puts response.error
  #   end
  #
  # rubocop:disable Metrics/ClassLength
  class SimpleCacheClient
    VERSION = Momento::VERSION
    CACHE_CLIENT_STUB_CLASS = CacheClient::Scs::Stub
    CONTROL_CLIENT_STUB_CLASS = ControlClient::ScsControl::Stub

    # @return [Numeric] the default time-to-live, in seconds.
    attr_accessor :default_ttl

    # @param auth_token [String] the JWT for your Momento account
    # @param default_ttl [Numeric] time-to-live, in seconds
    # @raise [ArgumentError] if the default_ttl or auth_token is invalid
    def initialize(auth_token:, default_ttl:)
      @auth_token = auth_token
      @default_ttl = Momento::Ttl.to_ttl(default_ttl)
      load_endpoints_from_token
    end

    # Get a value in a cache.
    #
    # Momento only stores bytes; the returned value will be encoded as ASCII-8BIT.
    #
    # @param cache_name [String]
    # @param key [String] must only contain ASCII characters
    # @return [Momento::GetResponse]
    # @raise [TypeError] when the key is not a String
    def get(cache_name, key)
      builder = GetResponseBuilder.new(
        context: { cache_name: cache_name, key: key }
      )

      return builder.from_block do
        validate_cache_name(cache_name)

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
    # @param ttl [Numeric] time-to-live, in seconds.
    # @raise [ArgumentError] if the ttl is invalid
    # @return [Momento::SetResponse]
    # @raise [TypeError] when the key or value is not a String
    def set(cache_name, key, value, ttl: default_ttl)
      ttl = Momento::Ttl.to_ttl(ttl)

      builder = SetResponseBuilder.new(
        context: { cache_name: cache_name, key: key, value: value, ttl: ttl }
      )

      return builder.from_block do
        validate_cache_name(cache_name)

        req = CacheClient::SetRequest.new(
          cache_key: to_bytes(key),
          cache_body: to_bytes(value),
          ttl_milliseconds: ttl.milliseconds
        )

        cache_stub.set(req, metadata: { cache: cache_name })
      end
    end

    # Delete a key in a cache.
    #
    # @param cache_name [String]
    # @param key [String] must only contain ASCII characters
    # @return [Momento::DeleteResponse]
    # @raise [TypeError] when the key or value is not a String
    def delete(cache_name, key)
      builder = DeleteResponseBuilder.new(
        context: { cache_name: cache_name, key: key }
      )

      return builder.from_block do
        validate_cache_name(cache_name)

        cache_stub.delete(
          CacheClient::DeleteRequest.new(cache_key: to_bytes(key)),
          metadata: { cache: cache_name }
        )
      end
    end

    # Create a new Momento cache.
    #
    # @param cache_name [String] the name of the cache to create.
    # @return [Momento::CreateCacheResponse] the response from Momento.
    def create_cache(cache_name)
      builder = CreateCacheResponseBuilder.new(
        context: { cache_name: cache_name }
      )

      return builder.from_block do
        validate_cache_name(cache_name)

        control_stub.create_cache(
          ControlClient::CreateCacheRequest.new(cache_name: cache_name)
        )
      end
    end

    # Delete an existing Momento cache.
    #
    # @param cache_name [String] the name of the cache to delete.
    # @return [Momento::DeleteCacheResponse] the response from Momento.
    def delete_cache(cache_name)
      builder = DeleteCacheResponseBuilder.new(
        context: { cache_name: cache_name }
      )

      return builder.from_block do
        validate_cache_name(cache_name)

        control_stub.delete_cache(
          ControlClient::DeleteCacheRequest.new(cache_name: cache_name)
        )
      end
    end

    # List a page of your caches.
    #
    # @note Consider using `caches` instead.
    #
    # The next_token indicates which page to fetch.
    # If nil or "" it will fetch the first page. Default is to fetch the first page.
    #
    # @param next_token [String, nil] the token of the page to request
    # @return [Momento::ListCachesResponse]
    def list_caches(next_token: "")
      builder = ListCachesResponseBuilder.new(
        context: { next_token: next_token }
      )
      return builder.from_block do
        control_stub.list_caches(
          ControlClient::ListCachesRequest.new(next_token: next_token)
        )
      end
    end

    # Lists the names of all your caches.
    #
    # @note Unlike other methods, this will raise if there is a problem
    #   with the client or service.
    #
    # @return [Enumerator::Lazy<String>] the cache names
    # @raise [Momento::Error] when there is an error listing caches.
    def caches
      Enumerator.new do |yielder|
        next_token = ""

        loop do
          response = list_caches(next_token: next_token)
          raise response.error if response.is_a? Momento::Response::Error

          response.cache_names.each do |name|
            yielder << name
          end

          break if response.next_token == ''

          next_token = response.next_token
        end
      end.lazy
    end

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
    rescue JWT::DecodeError
      raise ArgumentError, "Invalid Momento auth token."
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
    # @raise [TypeError] when the string is not a String
    def to_bytes(string)
      raise TypeError, "expected a String, got a #{string.class}" unless string.is_a?(String)

      # dup in case the value is frozen and to avoid changing the value's encoding
      # for the caller.
      return string.dup.force_encoding(Encoding::ASCII_8BIT)
    end

    # This is not a complete validation of the cache name, just
    # issues that might cause an exception in the client. Let the server
    # handle the rest of the validation.
    #
    # @param name [String] the cache name to validate
    # @raise [TypeError] when the name is not a String
    # @raise [Momento::CacheNameError] when the name is not ASCII
    def validate_cache_name(name)
      raise TypeError, "Cache name must be a String, got a #{name.class}" unless name.is_a?(String)
      raise Momento::CacheNameError, "Cache name must be ASCII, got '#{name}'" if name.match?(/[^[:ascii:]]/)

      return
    end
  end
  # rubocop:enable Metrics/ClassLength
end
