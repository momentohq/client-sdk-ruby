module Momento
  class Response
    module DeleteCache
      # Build a Momento::Response::DeleteCache::Error from a
      # gRPC exception.
      #
      # @param [GRPC::BadStatus]
      # @return [Momento::Response::DeleteCache::Error]
      # @raise [StandardError] when the gRPC exception is not recognized.
      class Builder < Builder
        def self.build_response(grpc_exception)
          case grpc_exception
          when GRPC::InvalidArgument
            DeleteCache::InvalidArgument.new(grpc_exception: grpc_exception)
          when GRPC::NotFound
            DeleteCache::NotFound.new(grpc_exception: grpc_exception)
          when GRPC::PermissionDenied
            DeleteCache::PermissionDenied.new(grpc_exception: grpc_exception)
          else
            super
          end
        end
      end

      class Error < Error
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
