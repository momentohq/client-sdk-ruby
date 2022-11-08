module Momento
  class Response
    # Responses for create_cache
    class DeleteCache < Response
      def self.build_response(grpc_exception)
        case grpc_exception
        when GRPC::InvalidArgument
          DeleteCache::InvalidArgument.new(grpc_exception: grpc_exception)
        when GRPC::NotFound
          DeleteCache::NotFound.new(grpc_exception: grpc_exception)
        when GRPC::PermissionDenied
          DeleteCache::PermissionDenied.new(grpc_exception: grpc_exception)
        else
          raise "Unknown GRPC exception: #{grpc_exception}"
        end
      end

      class Deleted < ::Momento::Response
      end

      class InvalidArgument < Error
      end

      class NotFound < Error
      end

      class PermissionDenied < Error
      end
    end
  end
end
