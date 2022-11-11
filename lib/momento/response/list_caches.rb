module Momento
  class Response
    # Responses for create_cache
    class ListCaches < Response
      def self.build_response(grpc_exception)
        case grpc_exception
        when GRPC::PermissionDenied
          ListCaches::PermissionDenied.new(grpc_exception: grpc_exception)
        else
          raise "Unknown GRPC exception: #{grpc_exception}"
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
