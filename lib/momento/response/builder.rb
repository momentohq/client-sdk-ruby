module Momento
  class Response
    # Base class to build Momento::Response::Error from
    # gRPC exceptions. This base class always raises.
    #
    # @return [Momento::Response::Error]
    # @param [GRPC::BadStatus]
    # @raise [StandardError] when the gRPC exception is not recognized.
    class Builder
      def self.build_response(grpc_exception)
        raise "Unknown GRPC exception: #{grpc_exception}"
      end
    end
  end
end
