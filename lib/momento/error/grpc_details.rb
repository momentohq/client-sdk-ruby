module Momento
  module Error
    # Details about a GRPC error.
    # Returned by `response.error.transport_details.grpc`
    #
    # @example
    #   # Information about the underlying GRPC error which
    #   # caused a Momento error response.
    #   puts response.error.transport_details.grpc.details
    class GrpcDetails
      # @return [GRPC::BadStatus] the GRPC exception
      attr_reader :grpc

      # @param grpc [GRPC::BadStatus] the GRPC exception to wrap
      def initialize(grpc)
        @grpc = grpc
      end

      # The GRPC numeric error code
      # @return [Integer]
      def code
        grpc.code
      end

      # Any details about the error provided by GRPC
      # @return [String]
      def details
        grpc.details
      end

      # Any metadata associated with the GRPC error
      # @return [Hash]
      def metadata
        grpc.metadata
      end
    end
  end
end
