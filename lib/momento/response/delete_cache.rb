module Momento
  class Response
    # Responses specific to delete_cache
    module DeleteCache
      # Build a Momento::Response::CreateCache from a block of code
      # which returns a Momento::ControlClient::DeleteCacheResponse..
      #
      # @return [Momento::Response::DeleteCache]
      # @raise [StandardError] when the exception is not recognized.
      # @raise [TypeError] when the response is not recognized.
      def self.from_block
        response = yield
      rescue GRPC::InvalidArgument => e
        DeleteCache::Error::InvalidArgument.new(grpc_exception: e)
      rescue GRPC::NotFound => e
        DeleteCache::Error::NotFound.new(grpc_exception: e)
      rescue GRPC::PermissionDenied => e
        DeleteCache::Error::PermissionDenied.new(grpc_exception: e)
      else
        raise TypeError unless response.is_a?(Momento::ControlClient::DeleteCacheResponse)

        return DeleteCache::Success.new(response)
      end

      # The cache was deleted.
      class Success < Success
      end

      # There was an error deleting the cache.
      class Error < Error
        # The cache name was not a possible cache name.
        class InvalidArgument < Error
        end

        # The cache name does not exist.
        class NotFound < Error
        end

        # The client does not have permission to delete the cache.
        class PermissionDenied < Error
        end
      end
    end
  end
end
