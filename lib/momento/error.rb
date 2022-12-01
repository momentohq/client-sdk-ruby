require_relative 'error/types'

module Momento
  # Errors from the Momento client or service.
  # Usually available as `response.error`.
  # Momento::Errors are Exceptions and can be raised.
  module Error
    # @return [Exception] the original exception which was the cause of the error
    attr_accessor :cause
    # @return [Hash] any context relevant to the error such as method arguments
    attr_accessor :context
    # @return [Momento::Error::TransportDetails] details about the transport layer
    attr_accessor :transport_details
    # @return [String] details about the error
    attr_accessor :details

    # @!method error_code
    #   A Momento-specific code for the type of error.
    #   @return [Symbol]

    # @!method message
    #   The error message.
    #   @return [String]

    # (see #message)
    def to_s
      message
    end
  end
end
