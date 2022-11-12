module Momento
  class Response
    # A superclass for all successful responses.
    class Success < Response
      # The wrapped gRPC response.
      attr_accessor :grpc_response

      # @params [Momento::Response] the gRPC response to wrap
      # rubocop:disable Lint/MissingSuper
      def initialize(grpc_response)
        @grpc_response = grpc_response
      end
      # rubocop:enable Lint/MissingSuper
    end
  end
end
