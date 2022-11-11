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
        DeleteCache::InvalidArgument.new(grpc_exception: e)
      rescue GRPC::NotFound => e
        DeleteCache::NotFound.new(grpc_exception: e)
      rescue GRPC::PermissionDenied => e
        DeleteCache::PermissionDenied.new(grpc_exception: e)
      else
        raise TypeError unless response.is_a?(Momento::ControlClient::DeleteCacheResponse)

        Momento::Response::DeleteCache::Success.new
      end

      class Error < Error
      end

      class InvalidArgument < Error
      end

      class NotFound < Error
      end

      class PermissionDenied < Error
      end

      class Success < Success
      end
    end
  end
end
