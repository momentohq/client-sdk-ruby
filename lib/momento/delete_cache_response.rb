require_relative 'response/error'

module Momento
  # Responses specific to delete_cache
  class DeleteCacheResponse < Response
    def success?
      false
    end

    # There was an error deleting the cache.
    class Error < DeleteCacheResponse
      include ::Momento::Response::Error
    end

    # The cache was deleted.
    class Success < DeleteCacheResponse
      def success?
        true
      end
    end
  end
end
