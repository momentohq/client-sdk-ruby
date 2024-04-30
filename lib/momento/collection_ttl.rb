module Momento
  # Represents the desired behavior for managing the TTL on collection objects.
  #
  # For cache operations that modify a collection (dictionaries, lists, or sets), there
  # are a few things to consider. The first time the collection is created, we need to
  # set a TTL on it. For subsequent operations that modify the collection you may choose
  # to update the TTL in order to prolong the life of the cached collection object, or
  # you may choose to leave the TTL unmodified in order to ensure that the collection
  # expires at the original TTL.
  #
  # The default behaviour is to refresh the TTL (to prolong the life of the collection)
  # each time it is written using the client's default item TTL.
  class CollectionTtl
    attr_reader :ttl_seconds, :refresh_ttl

    # Create a CollectionTtl with optional ttl seconds and refresh.
    # @param ttl_seconds [Integer | nil] the time to live of the collection. Uses the client default TTL if nil.
    # @param refresh_ttl [Boolean] whether to refresh the collection's ttl when performing a cache operation.
    # @return [Momento::CollectionTtl]
    def initialize(ttl_seconds = nil, refresh_ttl: true)
      validate_ttl_seconds(ttl_seconds) unless ttl_seconds.nil?
      @ttl_seconds = ttl_seconds
      @refresh_ttl = refresh_ttl
    end

    def ttl_milliseconds
      @ttl_seconds.nil? ? nil : @ttl_seconds * 1000
    end

    # Creates a CollectionTtl that refreshes and uses the default client TTL.
    # @return [Momento::CollectionTtl]
    def self.from_cache_ttl
      new
    end

    # Creates a CollectionTtl with the given TTL.
    # @param ttl_seconds [Integer | nil] the time to live of the collection. Uses the client default TTL if nil.
    # @return [Momento::CollectionTtl]
    def self.of(ttl_seconds)
      new(ttl_seconds)
    end

    # Creates a CollectionTtl that sets refresh to true if ttl_seconds is provided and false otherwise
    # @param ttl_seconds [Integer | nil] the time to live of the collection. If not nil, refresh is set to true.
    # @return [Momento::CollectionTtl]
    def self.refresh_ttl_if_provided(ttl_seconds = nil)
      new(ttl_seconds, refresh_ttl: !ttl_seconds.nil?)
    end

    # Copy constructor that uses the given TTL only if the parent CollectionTtl doesn't have one.
    # @param ttl_seconds [Integer | nil] the time to live of the collection. Will be ignored if the parent has a TTL.
    # @return [Momento::CollectionTtl]
    def with_ttl_if_absent(ttl_seconds)
      self.class.new(@ttl_seconds || ttl_seconds, refresh_ttl: @refresh_ttl)
    end

    # Copy constructor that uses the parent TTL and refreshes.
    # @return [Momento::CollectionTtl]
    def with_refresh_ttl_on_updates
      self.class.new(@ttl_seconds)
    end

    def with_no_refresh_ttl_on_updates
      self.class.new(@ttl_seconds, refresh_ttl: false)
    end

    def to_s
      "ttl: #{@ttl_seconds || 'null'}, refreshTtl: #{@refresh_ttl ? 'true' : 'false'}"
    end

    private

    def validate_ttl_seconds(ttl_seconds)
      raise ArgumentError, "TTL must be a positive integer" unless ttl_seconds.is_a?(Integer) && ttl_seconds.positive?
    end
  end
end
