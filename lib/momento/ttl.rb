module Momento
  # Internal class
  #
  # Validates and represents a time-to-live.
  class Ttl
    class << self
      # Create a Momento::Ttl object.
      #
      # If given a Momento::Ttl it will return it.
      # This means you don't have to check if it's already a Momento::Ttl
      #
      # @example
      #   ttl = Momento::Ttl.to_ttl(ttl)
      # @param ttl [Numeric,Momento::Ttl] the TTL in seconds, or an existing Ttl object
      # @return [Momento::Ttl]
      def to_ttl(ttl)
        return ttl if ttl.is_a?(self)

        raise ArgumentError, "ttl '#{ttl}' is not Numeric" unless ttl.is_a?(Numeric)
        raise ArgumentError, "ttl #{ttl} is less than 0" if ttl.negative?

        new(ttl)
      end
    end

    # @return [Numeric] the TTL in seconds
    attr_reader :seconds

    def initialize(ttl)
      @seconds = ttl
    end

    # @return [Numeric] the TTL in milliseconds
    def milliseconds
      @seconds * 1_000
    end

    def ==(other)
      return false unless other.is_a?(Momento::Ttl)

      milliseconds == other.milliseconds
    end

    def to_s
      "#{seconds} seconds"
    end
  end
end
