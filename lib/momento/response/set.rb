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
        Set::InvalidArgument.new(grpc_exception: e)
      rescue GRPC::NotFound => e
        Set::NotFound.new(grpc_exception: e)
      rescue GRPC::PermissionDenied => e
        Set::PermissionDenied.new(grpc_exception: e)
      else
        raise TypeError unless response.is_a?(Momento::CacheClient::SetResponse)

        Set::Success.new(response)
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
