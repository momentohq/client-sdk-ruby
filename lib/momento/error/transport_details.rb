module Momento
  module Error
    # A class to capture information specific to particular transport layers.
    #
    # @example
    #   # Information about the underlying GRPC error which
    #   # caused a Momento error response.
    #   puts response.error.transport_details.grpc.details
    class TransportDetails
      # Details specific to GRPC.
      # @return [Momento::Error::GrpcDetails]
      attr_reader :grpc

      # param grpc [GRPC::BadStatus]
      def initialize(grpc:)
        @grpc = GrpcDetails.new(grpc)
      end
    end
  end
end
