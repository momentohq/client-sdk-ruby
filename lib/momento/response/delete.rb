module Momento
  class Response
    # Responses specific to delete.
    module Delete
      def self.from_block
        response = yield
      rescue Encoding::UndefinedConversionError, GRPC::InvalidArgument => e
        Delete::InvalidArgument.new(grpc_exception: e)
      rescue GRPC::NotFound => e
        Delete::NotFound.new(grpc_exception: e)
      rescue GRPC::PermissionDenied => e
        Delete::PermissionDenied.new(grpc_exception: e)
      else
        raise TypeError unless response.is_a?(Momento::CacheClient::DeleteResponse)

        Delete::Success.new(response)
      end

      # Cache name is invalid.
      class InvalidArgument < Error
      end

      # Cache is not found.
      class NotFound < Error
      end

      class Success < Success
      end

      class PermissionDenied < Error
      end
    end
  end
end
