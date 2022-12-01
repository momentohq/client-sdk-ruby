require_relative 'response/error'

module Momento
  # A response from deleting a cache.
  class DeleteCacheResponse < Response
    # Was the cache deleted?
    # @return [Boolean]
    def success?
      false
    end

    # @private
    class Error < DeleteCacheResponse
      include ::Momento::Response::Error
    end

    # @private
    class Success < DeleteCacheResponse
      def success?
        true
      end
    end
  end
end
