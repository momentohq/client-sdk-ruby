require 'grpc'
require 'momento/controlclient_pb'

module Momento
  # Responses specific to list_caches.
  class ListCachesResponse < Response
    # Build a Momento::ListCachesResponse from a block of code
    # which returns a Momento::ControlClient::ListCachesResponse.
    #
    # @return [Momento::ListCachesResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def self.from_block
      response = yield
    rescue GRPC::BadStatus => e
      Error.new(grpc_exception: e)
    else
      raise TypeError unless response.is_a?(Momento::ControlClient::ListCachesResponse)

      return Caches.new(grpc_response: response)
    end

    def caches?
      false
    end

    # A Momento resposne with a page of caches.
    class Caches < ListCachesResponse
      # rubocop:disable Lint/MissingSuper
      def initialize(grpc_response:)
        @grpc_response = grpc_response
      end
      # rubocop:enable Lint/MissingSuper

      def caches?
        true
      end

      def cache_names
        @grpc_response.cache.map(&:cache_name)
      end

      def next_token
        @grpc_response.next_token
      end
    end

    # There was an error listing the caches.
    class Error < ListCachesResponse
      include ::Momento::Response::Error
    end
  end
end
