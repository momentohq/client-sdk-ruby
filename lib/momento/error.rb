require_relative 'error/types'

module Momento
  # Errors from the Momento client or service.
  # Usually available as `response.error`.
  module Error
    # @return [Exception] the original exception which was the cause of the error
    attr_accessor :cause
    # @return [Hash] any context relevant to the error such as method arguments
    attr_accessor :context
    # @return [Momento::Error::TransportDetails] details about the transport layer
    attr_accessor :transport_details
    # @return [String] details about the error
    attr_accessor :details

    # (see #message)
    def to_s
      message
    end
  end
end
