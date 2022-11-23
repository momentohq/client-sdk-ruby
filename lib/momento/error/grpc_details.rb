module Momento
  class Error
    # Details about a GRPC error.
    class GrpcDetails
      attr_reader :grpc

      def initialize(grpc)
        @grpc = grpc
      end

      def code
        grpc.status
      end

      def details
        grpc.details
      end

      def metadata
        grpc.metadata
      end
    end
  end
end
