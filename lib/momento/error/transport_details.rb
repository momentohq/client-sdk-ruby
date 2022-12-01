module Momento
  module Error
    # A class to capture information specific to a particular transport layer.
    class TransportDetails
      attr_reader :grpc

      def initialize(grpc:)
        @grpc = GrpcDetails.new(grpc)
      end
    end
  end
end
