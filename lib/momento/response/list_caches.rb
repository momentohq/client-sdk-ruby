module Momento
  class Response
    module ListCaches
      # Build a Momento::Response::ListCaches::Error from a
      # gRPC exception.
      #
      # @param [GRPC::BadStatus]
      # @return [Momento::Response::ListCaches::Error]
      # @raise [StandardError] when the gRPC exception is not recognized.
      class Builder < Builder
        def self.build_response(grpc_exception)
          case grpc_exception
          when GRPC::PermissionDenied
            ListCaches::PermissionDenied.new(grpc_exception: grpc_exception)
          else
            super
          end
        end
      end

      # Response wrapper for ListCachesResponse.
      class Caches < ::Momento::Response
        # rubocop:disable Lint/MissingSuper
        # @params [Momento::ControlClient::ListCachesResponse] the response to wrap
        def initialize(grpc_response)
          @grpc_response = grpc_response
        end
        # rubocop:enable Lint/MissingSuper

        def cache_names
          @grpc_response.cache.map(&:cache_name)
        end

        def next_token
          @grpc_response.next_token
        end
      end

      class PermissionDenied < Error
      end
    end
  end
end
