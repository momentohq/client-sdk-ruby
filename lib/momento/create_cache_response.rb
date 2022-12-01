require_relative 'response/error'

module Momento
  # A response from creating a cache.
  class CreateCacheResponse < Response
    # Does the cache already exist?
    # @return [Boolean]
    def already_exists?
      false
    end

    # Was the cache created?
    # @return [Boolean]
    def success?
      false
    end

    # @private
    class AlreadyExists < CreateCacheResponse
      def already_exists?
        true
      end
    end

    # @private
    class Success < CreateCacheResponse
      def success?
        true
      end
    end

    # @private
    class Error < CreateCacheResponse
      include ::Momento::Response::Error
    end
  end
end
