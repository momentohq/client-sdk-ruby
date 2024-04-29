module Momento
  # A superclass for building responses.
  #
  # @private
  class ResponseBuilder
    attr_accessor :context

    RESCUED_EXCEPTIONS = ErrorBuilder::EXCEPTION_MAP.keys.freeze

    def initialize(context: {})
      @context = context
    end

    def from_block
      raise NotImplementedError
    end
  end
end
