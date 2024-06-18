require_relative 'generated/cacheclient_services_pb'
require_relative 'generated/controlclient_services_pb'
require_relative 'response/response'
require_relative 'ttl'
require_relative 'exceptions'

module Momento
  # rubocop:disable Metrics/ClassLength

  # A simple client for Momento.
  #
  # CacheClient does not use exceptions to report errors.
  # Instead it returns an error response. Please see {file:README.md#label-Error+Handling}.
  #
  # @example
  #   credential_provider = Momento::CredentialProvider.from_env_var('MOMENTO_API_KEY')
  #   config = Momento::Cache::Configurations::Laptop.latest
  #   client = Momento::CacheClient.new(
  #     configuration: config,
  #     credential_provider: credential_provider,
  #     # cached items will be deleted after 100 seconds
  #     default_ttl: 100
  #   )
  #
  #   response = client.create_cache("my_cache")
  #   if response.success?
  #     puts "my_cache was created"
  #   elsif response.already_exists?
  #     puts "my_cache already exists"
  #   elsif response.error?
  #     raise response.error
  #   end
  #
  #   # set will only return success or error,
  #   # we only need to check for error
  #   response = client.set("my_cache", "key", "value")
  #   raise response.error if response.error?
  #
  #   response = client.get("my_cache", "key")
  #   if response.hit?
  #     puts "We got #{response.value_string}"
  #   elsif response.miss?
  #     puts "It's not in the cache"
  #   elsif response.error?
  #     raise response.error
  #   end
  #
  # @see Momento::Response
  class CacheClient
    # This gem's version.
    VERSION = Momento::VERSION
    CACHE_CLIENT_STUB_CLASS = MomentoProtos::CacheClient::Scs::Stub
    CONTROL_CLIENT_STUB_CLASS = MomentoProtos::ControlClient::ScsControl::Stub
    private_constant :CACHE_CLIENT_STUB_CLASS, :CONTROL_CLIENT_STUB_CLASS

    # @return [Numeric] how long items should remain in the cache, in seconds.
    attr_accessor :default_ttl

    # @param configuration [Momento::Cache::Configuration] the configuration for the client
    # @param credential_provider [Momento::CredentialProvider] the provider for the
    # credentials required to connect to Momento
    # @param default_ttl [Numeric] time-to-live, in seconds
    # @raise [ArgumentError] if the default_ttl or credential_provider is invalid
    def initialize(configuration:, credential_provider:, default_ttl:)
      @default_ttl = Momento::Ttl.to_ttl(default_ttl)
      @api_key = credential_provider.api_key
      @control_endpoint = credential_provider.control_endpoint
      @cache_endpoint = credential_provider.cache_endpoint
      @configuration = configuration
      @next_cache_stub_index = 0
      @num_cache_stubs = @configuration.transport_strategy.grpc_configuration.num_grpc_channels
      @is_first_request = true
    end

    # Get a value in a cache.
    #
    # The value can be retrieved as either bytes or a string.
    # @example
    #   response = client.get("my_cache", "key")
    #   if response.hit?
    #     puts "We got #{response.value_string}"
    #   elsif response.miss?
    #     puts "It's not in the cache"
    #   elsif response.error?
    #     raise response.error
    #   end
    #
    # @see Momento::GetResponse
    # @param cache_name [String]
    # @param key [String] must only contain ASCII characters
    # @return [Momento::GetResponse]
    # @raise [TypeError] when the cache_name or key is not a String
    def get(cache_name, key)
      builder = GetResponseBuilder.new(
        context: { cache_name: cache_name, key: key }
      )

      builder.from_block do
        cache_stub.get(
          MomentoProtos::CacheClient::PB__GetRequest.new(cache_key: to_bytes(key)),
          metadata: grpc_metadata(cache_name)
        )
      end
    end

    # Set a value in a cache.
    #
    # If ttl is not set, it will use the default_ttl.
    # @example
    #   response = client.set("my_cache", "key", "value")
    #   raise response.error if response.error?
    #
    # @see Momento::SetResponse
    # @param cache_name [String]
    # @param key [String] must only contain ASCII characters
    # @param value [String] the value to cache
    # @param ttl [Numeric] time-to-live, in seconds.
    # @raise [ArgumentError] if the ttl is invalid
    # @return [Momento::SetResponse]
    # @raise [TypeError] when the cache_name, key, or value is not a String
    def set(cache_name, key, value, ttl: default_ttl)
      ttl = Momento::Ttl.to_ttl(ttl)

      builder = SetResponseBuilder.new(
        context: { cache_name: cache_name, key: key, value: value, ttl: ttl }
      )

      builder.from_block do
        req = MomentoProtos::CacheClient::PB__SetRequest.new(
          cache_key: to_bytes(key),
          cache_body: to_bytes(value),
          ttl_milliseconds: ttl.milliseconds
        )

        cache_stub.set(req, metadata: grpc_metadata(cache_name))
      end
    end

    # Delete a key in a cache.
    #
    # If the key does not exist, delete will still succeed.
    # @example
    #   response = client.delete("my_cache", "key")
    #   raise response.error if response.error?
    #
    # @see Momento::DeleteResponse
    # @param cache_name [String]
    # @param key [String] must only contain ASCII characters
    # @return [Momento::DeleteResponse]
    # @raise [TypeError] when the cache_name or key is not a String
    def delete(cache_name, key)
      builder = DeleteResponseBuilder.new(
        context: { cache_name: cache_name, key: key }
      )

      builder.from_block do
        cache_stub.delete(
          MomentoProtos::CacheClient::PB__DeleteRequest.new(cache_key: to_bytes(key)),
          metadata: grpc_metadata(cache_name)
        )
      end
    end

    # Create a new Momento cache.
    # @example
    #   response = client.create_cache("my_cache")
    #   if response.success?
    #     puts "my_cache was created"
    #   elsif response.already_exists?
    #     puts "my_cache already exists"
    #   elsif response.error?
    #     raise response.error
    #   end
    #
    # @see Momento::CreateCacheResponse
    # @param cache_name [String] the name of the cache to create.
    # @return [Momento::CreateCacheResponse] the response from Momento.
    # @raise [TypeError] when the cache_name is not a String
    def create_cache(cache_name)
      builder = CreateCacheResponseBuilder.new(
        context: { cache_name: cache_name }
      )

      builder.from_block do
        control_stub.create_cache(
          MomentoProtos::ControlClient::PB__CreateCacheRequest.new(cache_name: validate_cache_name(cache_name))
        )
      end
    end

    # Delete an existing Momento cache.
    #
    # @example
    #   response = client.delete_cache("my_cache")
    #   raise response.error if response.error?
    #
    # @see Momento::DeleteCacheResponse
    # @param cache_name [String] the name of the cache to delete.
    # @return [Momento::DeleteCacheResponse] the response from Momento.
    # @raise [TypeError] when the cache_name is not a String
    def delete_cache(cache_name)
      builder = DeleteCacheResponseBuilder.new(
        context: { cache_name: cache_name }
      )

      builder.from_block do
        control_stub.delete_cache(
          MomentoProtos::ControlClient::PB__DeleteCacheRequest.new(cache_name: validate_cache_name(cache_name))
        )
      end
    end

    # Lists your caches.
    #
    # @see Momento::ListCachesResponse
    # @return [Momento::ListCachesResponse]
    def list_caches
      builder = ListCachesResponseBuilder.new(
        context: {}
      )
      builder.from_block do
        control_stub.list_caches(
          MomentoProtos::ControlClient::PB__ListCachesRequest.new
        )
      end
    end

    # Put an element in a sorted set
    #
    # If collection_ttl is not set, it will use the default_ttl.
    # @example
    #   response = client.sorted_set_put_element('my_cache', 'my_set', 'value', 1.0)
    #   raise response.error if response.error?
    #
    # @see Momento::SortedSetPutElementResponse
    # @param cache_name [String]
    # @param sorted_set_name [String]
    # @param value [String] the value to add to the sorted set.
    # @param score [Float] the score of the value. Determines its place in the set.
    # @param collection_ttl [Momento::CollectionTtl] time-to-live, in seconds.
    # @raise [ArgumentError] if the ttl is invalid
    # @return [Momento::SortedSetPutElementResponse]
    # @raise [TypeError] when the cache_name, sorted_set_name, or value is not a String
    def sorted_set_put_element(cache_name, sorted_set_name, value, score, collection_ttl: CollectionTtl.from_cache_ttl)
      collection_ttl = collection_ttl.with_ttl_if_absent(default_ttl.seconds)
      builder = SortedSetPutElementResponseBuilder.new(
        context: { cache_name: cache_name, set_name: sorted_set_name, value: value, score: score,
                   collection_ttl: collection_ttl }
      )

      builder.from_block do
        req = MomentoProtos::CacheClient::PB__SortedSetPutRequest.new(
          set_name: to_bytes(sorted_set_name),
          elements: [{ value: to_bytes(value), score: score }],
          ttl_milliseconds: collection_ttl.ttl_milliseconds,
          refresh_ttl: collection_ttl.refresh_ttl
        )

        # noinspection RubyResolve
        cache_stub.sorted_set_put(req, metadata: grpc_metadata(cache_name))
      end
    end

    # Put multiple elements in a sorted set
    #
    # If collection_ttl is not set, it will use the default_ttl.
    # @example
    #   response = client.sorted_set_put_element('my_cache', 'my_set', [['value', 1.0]])
    #   raise response.error if response.error?
    #
    # @see Momento::SortedSetPutElementsResponse
    # @param cache_name [String]
    # @param sorted_set_name [String]
    # @param elements [Hash, Array] the elements to add. Must be a hash of String values to Float scores,
    # an array of arrays [["value", 1.0]], or an array of hashes of value and score [{value: "value", score: 1.0}].
    # @param collection_ttl [Integer] time-to-live, in seconds.
    # @raise [ArgumentError] if the ttl is invalid
    # @return [Momento::SortedSetPutElementsResponse]
    # @raise [TypeError] when the cache_name, or sorted_set_name is not a String, or if elements is not
    # an Array or Hash
    def sorted_set_put_elements(cache_name, sorted_set_name, elements, collection_ttl = CollectionTtl.from_cache_ttl)
      collection_ttl = collection_ttl.with_ttl_if_absent(default_ttl.seconds)
      builder = SortedSetPutElementsResponseBuilder.new(
        context: { cache_name: cache_name, set_name: sorted_set_name, elements: elements,
                   collection_ttl: collection_ttl }
      )

      builder.from_block do
        req = MomentoProtos::CacheClient::PB__SortedSetPutRequest.new(
          set_name: to_bytes(sorted_set_name),
          elements: to_sorted_set_elements(elements),
          ttl_milliseconds: collection_ttl.ttl_milliseconds,
          refresh_ttl: collection_ttl.refresh_ttl
        )

        # noinspection RubyResolve
        cache_stub.sorted_set_put(req, metadata: grpc_metadata(cache_name))
      end
    end

    # rubocop:disable Metrics/ParameterLists

    # Fetch the elements a sorted set by score.
    #
    # @example
    #   response = client.sorted_set_fetch_by_score("my_cache", "sorted_set", min_score: 0.0, max_score: 1.0)
    #   raise response.error if response.error?
    #
    # @see Momento::SortedSetFetchResponse
    # @param cache_name [String]
    # @param sorted_set_name [String]
    # @param min_score [Float] The minimum score (inclusive) of the elements to fetch. Defaults to negative infinity.
    # @param max_score [Float] The maximum score (inclusive) of the elements to fetch. Defaults to positive infinity.
    # @param sort_order [SortOrder] The order to fetch the elements in. Defaults to ascending.
    # @param offset [Integer] The number of elements to skip before returning the first element. Defaults to 0.
    # @param count [Integer] The maximum number of elements to return. Defaults to all elements.
    # @return [Momento::SortedSetFetchResponse]
    # @raise [TypeError] when the cache_name, or sorted_set_name is not a String.
    def sorted_set_fetch_by_score(cache_name, sorted_set_name, min_score: nil, max_score: nil,
                                  sort_order: SortOrder::ASCENDING, offset: 0, count: -1)
      builder = SortedSetFetchResponseBuilder.new(
        context: { cache_name: cache_name, set_name: sorted_set_name, min_score: min_score, max_score: max_score,
                   sort_order: sort_order, offset: offset, count: count }
      )

      builder.from_block do
        by_score = build_sorted_set_by_score(min_score, max_score, offset, count)

        req = MomentoProtos::CacheClient::PB__SortedSetFetchRequest.new(
          set_name: to_bytes(sorted_set_name),
          order: to_grpc_order(sort_order),
          with_scores: true,
          by_score: by_score
        )

        # noinspection RubyResolve
        cache_stub.sorted_set_fetch(req, metadata: grpc_metadata(cache_name))
      end
    end
    # rubocop:enable Metrics/ParameterLists

    private

    def cache_stub
      @cache_stubs ||= (1..@num_cache_stubs).map {
        CACHE_CLIENT_STUB_CLASS.new(@cache_endpoint, combined_credentials,
          timeout: @configuration.transport_strategy.grpc_configuration.deadline,
          channel_args: { 'grpc.use_local_subchannel_pool' => 1 }
        )
      }
      @next_cache_stub_index = (@next_cache_stub_index + 1) % @num_cache_stubs
      @cache_stubs[@next_cache_stub_index]
    end

    def control_stub
      @control_stub ||= CONTROL_CLIENT_STUB_CLASS.new(@control_endpoint, combined_credentials)
    end

    def combined_credentials
      @combined_credentials ||= make_combined_credentials
    end

    def make_combined_credentials
      # :nocov:
      auth_proc = proc do
        { authorization: @api_key }
      end
      # :nocov:

      call_creds = GRPC::Core::CallCredentials.new(auth_proc)

      GRPC::Core::ChannelCredentials.new.compose(call_creds)
    end

    def to_grpc_order(sort_order)
      case sort_order
      when SortOrder::ASCENDING
        MomentoProtos::CacheClient::PB__SortedSetFetchRequest::Order::ASCENDING
      when SortOrder::DESCENDING
        MomentoProtos::CacheClient::PB__SortedSetFetchRequest::Order::DESCENDING
      else
        raise TypeError, "Invalid sort order: #{sort_order}"
      end
    end

    # Momento accepts sorted sets as an array of hashes. This will transform an array of arrays [["value", 1.0]],
    # an array of hashes [{value: "value", score: 1.0}], or a hash of values to scores to the correct format.
    # @param elements [Hash, Array] A hash of string values to scores or an array of tuples (value, score)
    # # @return [Array<Hash>] An array of sorted set elements, where each element is a hash of :value and :score
    def to_sorted_set_elements(elements)
      case elements
      when Hash
        elements.map { |value, score| { value: to_bytes(value), score: score.to_f } }
      when Array
        if elements.first.is_a?(Hash)
          elements.map { |element| { value: to_bytes(element[:value]), score: element[:score].to_f } }
        else
          elements.map { |value, score| { value: to_bytes(value), score: score.to_f } }
        end
      else
        raise ArgumentError, "Sorted set elements must be a Hash or an Array of tuples"
      end
    end

    def build_sorted_set_by_score(min_score, max_score, offset, count)
      MomentoProtos::CacheClient::PB__SortedSetFetchRequest::PB__ByScore.new(
        min_score: min_score ? build_score(min_score) : nil,
        unbounded_min: min_score ? nil : MomentoProtos::Common::PB__Unbounded.new,
        max_score: max_score ? build_score(max_score) : nil,
        unbounded_max: max_score ? nil : MomentoProtos::Common::PB__Unbounded.new,
        offset: offset,
        count: count
      )
    end

    def build_score(score)
      MomentoProtos::CacheClient::PB__SortedSetFetchRequest::PB__ByScore::PB__Score.new(
        score: score,
        exclusive: false
      )
    end

    # Ruby uses String for bytes. GRPC wants a String encoded as ASCII.
    # GRPC will re-encode a String, but treats it as characters; GRPC will
    # raise if you pass a String with non-ASCII characters.
    # So we do the re-encoding ourselves in a way that treats the String as
    # bytes and will not raise. The data is not changed.
    #
    # If the input String is ASCII, we treat it as binary data. Otherwise,
    # we ensure it is encoded as UTF-8 to stop the SDK from being able to
    # write non-UTF-8 strings to the server.
    #
    # A duplicate String is returned, but since Ruby is copy-on-write it
    # does not copy the data.
    #
    # @param string [String] the string to make safe for GRPC bytes
    # @return [String] a duplicate safe to use as GRPC bytes
    # @raise [TypeError] when the string is not a String
    def to_bytes(string)
      raise TypeError, "expected a String, got a #{string.class}" unless string.is_a?(String)

      if string.encoding == Encoding::ASCII_8BIT
        string.dup
      else
        utf8_encoded = string.encode('UTF-8')
        utf8_encoded.force_encoding(Encoding::ASCII_8BIT)
      end
    end

    def grpc_metadata(cache_name)
      metadata = if @is_first_request
        @is_first_request = false
        {
          cache: validate_cache_name(cache_name),
          agent: "ruby:cache:#{VERSION}",
          "runtime-version": "ruby:#{RUBY_VERSION}",
        }
      else
        { cache: validate_cache_name(cache_name) }
      end
      puts "Using metadata: #{metadata}"
      metadata
    end


    # Return a UTF-8 version of the cache name.
    #
    # @param name [String] the cache name to validate
    # @raise [TypeError] when the name is not a String
    # @raise [Momento::CacheNameError] when the name is not UTF-8 compatible
    def validate_cache_name(name)
      raise TypeError, "Cache name must be a String, got a #{name.class}" unless name.is_a?(String)

      encoded_name = name.encode('UTF-8')
      raise Momento::CacheNameError, "Cache name must be UTF-8 compatible" unless name.valid_encoding?

      encoded_name
    end
  end
  # rubocop:enable Metrics/ClassLength
end
