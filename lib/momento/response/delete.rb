module Momento
  class Response
    # Responses specific to delete.
    module Delete
      def self.from_block
        response = yield
      rescue Encoding::UndefinedConversionError, GRPC::InvalidArgument => e
        Delete::Error::InvalidArgument.new(grpc_exception: e)
      rescue GRPC::NotFound => e
        Delete::Error::NotFound.new(grpc_exception: e)
      rescue GRPC::PermissionDenied => e
        Delete::Error::PermissionDenied.new(grpc_exception: e)
      else
        raise TypeError unless response.is_a?(Momento::CacheClient::DeleteResponse)

        Delete::Success.new(response)
      end

      # The item was deleted from the cache.
      class Success < Success
      end

      # There was an error deleting the value from the cache.
      # See subclasses for more specific errors.
      class Error < Error
        # Cache name or key is not allowed.
        class InvalidArgument < Error
        end

        # Cache or key is not found.
        class NotFound < Error
        end

        # The client does not have permission to delete the item.
        class PermissionDenied < Error
        end
      end
    end
  end
end
