require_relative 'response/error'

module Momento
  # Responses specific to get.
  class GetResponse < Response
    # @return [Boolean] did we get a value
    def hit?
      false
    end

    # @return [Boolean] was there no value
    def miss?
      false
    end

    # @return [String,nil] the gotten value, if any.
    def value
      nil
    end

    # Successfully got an item from the cache.
    class Hit < GetResponse
      VALUE_DISPLAY_LENGTH = 32

      # rubocop:disable Lint/MissingSuper
      def initialize(grpc_response:)
        @grpc_response = grpc_response
      end
      # rubocop:enable Lint/MissingSuper

      def hit?
        true
      end

      def value
        @grpc_response.cache_body
      end

      def to_s
        "#{super}: #{display_value}"
      end

      private

      def display_value
        if value.length < VALUE_DISPLAY_LENGTH
          value
        else
          "#{value[0, VALUE_DISPLAY_LENGTH]}..."
        end
      end
    end

    # The key had no value stored in the cache.
    class Miss < GetResponse
      def miss?
        true
      end
    end

    # There was a problem getting the value from the cache.
    class Error < GetResponse
      include Momento::Response::Error
    end
  end
end
