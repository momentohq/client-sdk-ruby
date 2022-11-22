require 'grpc'
require 'momento/cacheclient_pb'

module Momento
  # Responses specific to get.
  class GetResponse < Response
    class << self
      # Build a Momento::GetResponse from a block of code
      # which returns a Momento::ControlClient::GetResponse.
      #
      # @return [Momento::GetResponse]
      # @raise [StandardError] when the exception is not recognized.
      # @raise [TypeError] when the response is not recognized.
      def from_block
        response = yield
      rescue GRPC::BadStatus => e
        Error.new(grpc_exception: e)
      else
        from_response(response)
      end

      private

      def from_response(response)
        raise TypeError unless response.is_a?(Momento::CacheClient::GetResponse)

        case response.result
        when :Hit
          Hit.new(grpc_response: response)
        when :Miss
          Miss.new
        else
          raise "Unknown get result: #{response.result}"
        end
      end
    end

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
        value
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
