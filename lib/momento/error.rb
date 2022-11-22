require_relative 'error/types'

module Momento
  # Errors from the Momento client or service.
  class Error
    attr_reader :exception, :context, :transport_metadata, :details

    def initialize(
      exception:,
      context: {},
      transport_metadata: nil,
      details: nil
    )
      @exception = exception
      @context = context
      @details = details
      @transport_metadata = transport_metadata
    end

    def error_code
      @error_code ||= self.class.name.split('::').last
    end

    def message
      raise NotImplementedEror
    end

    def to_s
      message
    end
  end
end
