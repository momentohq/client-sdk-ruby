module Momento
  class Response
    # A module for responses which contain errors.
    module Error
      attr_accessor :grpc_exception

      def initialize(grpc_exception:)
        @grpc_exception = grpc_exception
      end

      def error?
        true
      end
    end
  end
end
