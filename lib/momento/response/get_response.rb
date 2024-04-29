require_relative 'error'
require_relative '../generated/cacheclient_pb'

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

  # @private
  class GetResponseBuilder < ResponseBuilder
    # Build a Momento::GetResponse from a block of code
    # which returns a Momento::ControlClient::GetResponse.
    #
    # @return [Momento::GetResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def from_block
      response = yield
    rescue *RESCUED_EXCEPTIONS => e
      GetResponse::Error.new(exception: e, context: context)
    else
      from_response(response)
    end

    private

    def from_response(response)
      raise TypeError unless response.is_a?(MomentoProtos::CacheClient::PB__GetResponse)

      case response.result
      when :Hit
        GetResponse::Hit.new(grpc_response: response)
      when :Miss
        GetResponse::Miss.new
      else
        raise "Unknown get result: #{response.result}"
      end
    end
  end
end
