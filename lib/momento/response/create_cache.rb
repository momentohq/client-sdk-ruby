module Momento
  class Response
    module CreateCache
      # Build a Momento::Response::CreateCache::Error from a
      # gRPC exception.
      #
      # @param [GRPC::BadStatus]
      # @return [Momento::Response::CreateCache::Error]
      # @raise [StandardError] when the gRPC exception is not recognized.
      class Builder < Builder
        def self.build_response(grpc_exception)
          case grpc_exception
          when GRPC::AlreadyExists
            CreateCache::AlreadyExists.new(grpc_exception: grpc_exception)
          when GRPC::InvalidArgument
            CreateCache::InvalidArgument.new(grpc_exception: grpc_exception)
          when GRPC::PermissionDenied
            CreateCache::PermissionDenied.new(grpc_exception: grpc_exception)
          else
            super
          end
        end
      end

      class Error < Error
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
