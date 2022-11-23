require_relative 'error/types'

module Momento
  # Errors from the Momento client or service.
  class Error
    attr_reader :exception, :context, :transport_details, :details

    def initialize(
      exception:,
      context: {},
      transport_details: nil,
      details: nil
    )
      @exception = exception
      @context = context
      @details = details
      @transport_details = transport_details
    end

    # @return [String]
    def error_code
      raise NotImplementedError
    end

    # @return [String]
    def message
      raise NotImplementedError
    end

    def to_s
      message
    end
  end
end
