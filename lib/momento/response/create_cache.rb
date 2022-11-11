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
        CreateCache::AlreadyExists.new(grpc_exception: e)
      rescue GRPC::InvalidArgument => e
        CreateCache::InvalidArgument.new(grpc_exception: e)
      rescue GRPC::PermissionDenied => e
        CreateCache::PermissionDenied.new(grpc_exception: e)
      else
        raise TypeError unless response.is_a?(Momento::ControlClient::CreateCacheResponse)

        return Momento::Response::CreateCache::Success.new(response)
      end

      class AlreadyExists < Error
      end

      class Error < Error
      end

      class InvalidArgument < Error
      end

      class PermissionDenied < Error
      end

      class Success < Success
      end
    end
  end
end
