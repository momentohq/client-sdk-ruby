require_relative 'response/error'

module Momento
  # Responses specific to list_caches.
  class ListCachesResponse < Response
    def success?
      false
    end

    # A Momento resposne with a page of caches.
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

      def next_token
        @grpc_response.next_token
      end

      def to_s
        "#{super}: #{display_cache_names}"
      end

      private

      def display_cache_names
        display = cache_names.first(CACHE_NAMES_TO_DISPLAY).join(", ")

        if cache_names.size > CACHE_NAMES_TO_DISPLAY
          "#{display}, ..."
        else
          display
        end
      end
    end

    # There was an error listing the caches.
    class Error < ListCachesResponse
      include ::Momento::Response::Error
    end
  end
end
