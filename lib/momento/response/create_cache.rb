module Momento
  class Response
    # Responses for create_cache
    class CreateCache < Response
      def self.build_response(grpc_exception)
        case grpc_exception
        when GRPC::AlreadyExists
          CreateCache::AlreadyExists.new(grpc_exception: grpc_exception)
        when GRPC::InvalidArgument
          CreateCache::InvalidArgument.new(grpc_exception: grpc_exception)
        when GRPC::PermissionDenied
          CreateCache::PermissionDenied.new(grpc_exception: grpc_exception)
        else
          raise "Unknown GRPC exception: #{grpc_exception}"
        end
      end

      class AlreadyExists < Error
      end

      class Created < Momento::Response
      end

      class InvalidArgument < Error
      end

      class PermissionDenied < Error
      end
    end
  end
end
