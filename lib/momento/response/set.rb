module Momento
  class Response
    # Responses specific to set.
    module Set
      # Build a Momento::Response::Set from a block of code
      # which returns a Momento::ControlClient::SetResponse.
      #
      # @return [Momento::Response::Set]
      # @raise [StandardError] when the exception is not recognized.
      # @raise [TypeError] when the response is not recognized.
      def self.from_block
        response = yield
      rescue Encoding::UndefinedConversionError, GRPC::InvalidArgument => e
        Set::Error::InvalidArgument.new(grpc_exception: e)
      rescue GRPC::NotFound => e
        Set::Error::NotFound.new(grpc_exception: e)
      rescue GRPC::PermissionDenied => e
        Set::Error::PermissionDenied.new(grpc_exception: e)
      else
        raise TypeError unless response.is_a?(Momento::CacheClient::SetResponse)

        Set::Success.new(response)
      end

      # The value was set in the cache.
      class Success < Success
      end

      # There was an error setting the key/value.
      # See subclasses for more specific errors.
      class Error < Error
        # Cache name or key is invalid.
        class InvalidArgument < Error
        end

        # The cache is not found.
        class NotFound < Error
        end

        # The client does not have permission to set values in the cache.
        class PermissionDenied < Error
        end
      end
    end
  end
end
