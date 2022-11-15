module Momento
  class Response
    # Responses specific to create_cache.
    module CreateCache
      # Build a Momento::Response::CreateCache from a block of code
      # which returns a Momento::ControlClient::CreateCacheResponse.
      #
      # @return [Momento::Response::CreateCache]
      # @raise [StandardError] when the exception is not recognized.
      # @raise [TypeError] when the response is not recognized.
      def self.from_block
        response = yield
      rescue GRPC::AlreadyExists => e
        CreateCache::Error::AlreadyExists.new(grpc_exception: e)
      rescue GRPC::InvalidArgument => e
        CreateCache::Error::InvalidArgument.new(grpc_exception: e)
      rescue GRPC::PermissionDenied => e
        CreateCache::Error::PermissionDenied.new(grpc_exception: e)
      else
        raise TypeError unless response.is_a?(Momento::ControlClient::CreateCacheResponse)

        return CreateCache::Success.new(response)
      end

      # The cache was created.
      class Success < Success
      end

      # There was an error creating the cache.
      # See subclasses for more specific errors.
      class Error < Error
        # The cache already exists.
        class AlreadyExists < Error
        end

        # The cache name is invalid.
        class InvalidArgument < Error
        end

        # The client does not have permission to create the cache.
        class PermissionDenied < Error
        end
      end
    end
  end
end
