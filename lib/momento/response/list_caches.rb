module Momento
  class Response
    # Responses specific to list_caches.
    module ListCaches
      # Build a Momento::Response::ListCaches from a block of code
      # which returns a Momento::ControlClient::ListCachesResponse.
      #
      # @return [Momento::Response::ListCaches]
      # @raise [StandardError] when the exception is not recognized.
      # @raise [TypeError] when the response is not recognized.
      def self.from_block
        response = yield
      rescue GRPC::PermissionDenied => e
        ListCaches::Error::PermissionDenied.new(grpc_exception: e)
      else
        raise TypeError unless response.is_a?(Momento::ControlClient::ListCachesResponse)

        return ListCaches::Caches.new(response)
      end

      # Response wrapper for ListCachesResponse.
      class Caches < Success
        def cache_names
          @grpc_response.cache.map(&:cache_name)
        end

        def next_token
          @grpc_response.next_token
        end
      end

      class Error < Error
        class PermissionDenied < Error
        end
      end
    end
  end
end
