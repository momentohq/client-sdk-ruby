require_relative 'error'
require_relative '../generated/cacheclient_pb'

module Momento
  # A response from setting a key.
  class SetResponse < Response
    # Was the key/value pair added to the cache?
    # @return [Boolean]
    def success?
      false
    end

    # @private
    class Success < SetResponse
      attr_accessor :key, :value

      # rubocop:disable Lint/MissingSuper
      def initialize(key:, value:)
        @key = key
        @value = value

        return
      end
      # rubocop:enable Lint/MissingSuper

      def success?
        true
      end

      def to_s
        "#{super}: '#{display_string(key)}' = '#{display_string(value)}'"
      end
    end

    # @private
    class Error < SetResponse
      include Momento::Response::Error
    end
  end

  # @private
  class SetResponseBuilder < ResponseBuilder
    # Build a Momento::SetResponse from a block of code
    # which returns a Momento::CacheClient::SetResponse..
    #
    # @return [Momento::SetResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def from_block
      response = yield
    rescue *RESCUED_EXCEPTIONS => e
      SetResponse::Error.new(exception: e, context: context)
    else
      raise TypeError unless response.is_a?(::MomentoProtos::CacheClient::PB__SetResponse)

      SetResponse::Success.new(key: context[:key], value: context[:value])
    end
  end
end
