module Momento
  class Error
    # Details about a GRPC error.
    class GrpcDetails
      attr_reader :grpc

      def initialize(grpc)
        @grpc = grpc
      end

      # @return [Integer]
      def code
        grpc.code
      end

      # @return [String]
      def details
        grpc.details
      end

      # @return [Hash]
      def metadata
        grpc.metadata
      end
    end
  end
end
