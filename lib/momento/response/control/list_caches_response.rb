require_relative '../error'
require_relative '../../generated/controlclient_pb'

module Momento
  # A response from listing the caches.
  class ListCachesResponse < Response
    # Did it get a list of caches?
    # @return [Boolean]
    def success?
      false
    end

    # The names of the caches.
    # @return [Array,nil]
    def cache_names
      nil
    end

    # @!method to_s
    #   Displays the response and the list of cache names.
    #   The list of cache names will be truncated.
    #   @return [String]

    # @private
    class Success < ListCachesResponse
      CACHE_NAMES_TO_DISPLAY = 5

      # rubocop:disable Lint/MissingSuper
      def initialize(grpc_response:)
        @grpc_response = grpc_response
      end
      # rubocop:enable Lint/MissingSuper

      def success?
        true
      end

      def cache_names
        @grpc_response.cache.map(&:cache_name)
      end

      def to_s
        "#{super}: #{display_cache_names}"
      end

      private

      def display_cache_names
        display = cache_names&.take(CACHE_NAMES_TO_DISPLAY)&.join(", ")
        cache_names&.size&.>(CACHE_NAMES_TO_DISPLAY) ? "#{display}, ..." : display.to_s
      end
    end

    # @private
    class Error < ListCachesResponse
      include ::Momento::Response::Error
    end
  end

  # @private
  class ListCachesResponseBuilder < ResponseBuilder
    # Build a Momento::ListCachesResponse from a block of code
    # which returns a Momento::ControlClient::ListCachesResponse..
    #
    # @return [Momento::ListCachesResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def from_block
      response = yield
    rescue GRPC::BadStatus => e
      ListCachesResponse::Error.new(
        exception: e, context: context
      )
    else
      raise TypeError unless response.is_a?(::MomentoProtos::ControlClient::PB__ListCachesResponse)

      return ListCachesResponse::Success.new(grpc_response: response)
    end
  end
end
