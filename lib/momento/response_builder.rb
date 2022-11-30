module Momento
  # An internal class.
  #
  # A superclass for building responses.
  class ResponseBuilder
    attr_accessor :context

    RESCUED_EXCEPTIONS = [
      GRPC::BadStatus, *ErrorBuilder::OTHER_EXCEPTION_MAP.keys
    ].freeze

    def initialize(context: {})
      @context = context
    end

    def from_block
      raise NotImplementedError
    end
  end
end
