require_relative 'response/error'

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
end
