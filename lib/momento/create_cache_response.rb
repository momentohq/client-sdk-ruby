require_relative 'response/error'

module Momento
  # Responses specific to create_cache.
  class CreateCacheResponse < Response
    def already_exists?
      false
    end

    def success?
      false
    end

    # A cache with that name already exists.
    class AlreadyExists < CreateCacheResponse
      def already_exists?
        true
      end
    end

    # The cache was created.
    class Success < CreateCacheResponse
      def success?
        true
      end
    end

    # There was an error creating the cache.
    class Error < CreateCacheResponse
      include ::Momento::Response::Error
    end
  end
end
