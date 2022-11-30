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

    # The gotten value, if any, as binary data: an ASCII_8BIT encoded frozen String.
    #
    # @return [String,nil] the value, if any, frozen and ASCII_8BIT encoded
    def value_bytes
      nil
    end

    # The gotten value, if any, as a string using your default encoding or specified one.
    #
    # @param encoding [Encoding] defaults to Encoding.default_external
    # @return [String,nil] the value, if any, re-encoded
    def value_string
      nil
    end

    # Successfully got an item from the cache.
    class Hit < GetResponse
      # rubocop:disable Lint/MissingSuper
      def initialize(grpc_response:)
        @grpc_response = grpc_response
      end
      # rubocop:enable Lint/MissingSuper

      def hit?
        true
      end

      def value_bytes
        @grpc_response.cache_body
      end

      def value_string(encoding = Encoding.default_external)
        value_bytes.dup.force_encoding(encoding)
      end

      def to_s
        "#{super}: #{display_string(value_string)}"
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
