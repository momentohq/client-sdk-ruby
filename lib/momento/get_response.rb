require_relative 'response/error'

module Momento
  # A response containing the value retrieved from a cache.
  class GetResponse < Response
    # There was a value for the key.
    # @return [Boolean]
    def hit?
      false
    end

    # There was no value for the key.
    # @return [Boolean]
    def miss?
      false
    end

    # The gotten value, if any, as binary data: an ASCII_8BIT encoded frozen String.
    #
    # @return [String,nil] the value, if any, frozen and ASCII_8BIT encoded
    def value_bytes
      nil
    end

    # The gotten value, if any, as a UTF-8 string.
    #
    # @return [String,nil] the value, if any.
    def value_string
      nil
    end

    # @!method to_s
    #   Displays the response and the value, if any.
    #   A long value will be truncated.
    #   @return [String]

    # @private
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

      def value_string
        value_bytes.dup.force_encoding('UTF-8')
      end

      def to_s
        "#{super}: #{display_string(value_string)}"
      end
    end

    # @private
    class Miss < GetResponse
      def miss?
        true
      end
    end

    # @private
    class Error < GetResponse
      include Momento::Response::Error
    end
  end
end
