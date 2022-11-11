module Momento
  class Response
    # Superclass for all Responses wrapping an exception.
    class Error < Response
      attr_accessor :grpc_exception

      # rubocop:disable Lint/MissingSuper
      def initialize(grpc_exception:)
        @grpc_exception = grpc_exception
      end
      # rubocop:enable Lint/MissingSuper
    end
  end
end
