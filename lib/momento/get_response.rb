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

    def hit?
      false
    end

    def miss?
      false
    end

    # A successful get from the cache.
    class Hit < GetResponse
      # rubocop:disable Lint/MissingSuper
      def initialize(grpc_response:)
        @grpc_response = grpc_response
      end
      # rubocop:enable Lint/MissingSuper

      def hit?
        true
      end

      # @return [String] the value from the cache
      def value
        @grpc_response.cache_body
      end

      def to_s
        value
      end
    end

    class Miss < GetResponse
      def miss?
        true
      end
    end

    class Error < GetResponse
      include Momento::Response::Error
    end
  end
end
