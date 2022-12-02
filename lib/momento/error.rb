require_relative 'error/types'

module Momento
  # Errors from the Momento client or service, available as `response.error`.
  #
  # Momento::Errors are Exceptions. They can be raised. If the error was
  # caused by an exception, it will be available in {#cause}.
  #
  # @example
  #   # This is a contrived example to show what you can do with a Momento::Error.
  #   response = client.cache_name(cache_name, key)
  #   if response.error?
  #     error = response.error
  #
  #     puts "Creating the cache failed: #{error}"
  #     puts "The cause was #{error.cause}"
  #     puts "The details of the error are #{error.details}"
  #     puts "The error code is #{error.error_code}"
  #
  #     case error
  #     when Momento::Error::LimitExceededError
  #       puts "We'll have to slow down"
  #     when Momento::Error::PermissionError
  #       puts "We'll have to fix our auth token"
  #     when Momento::Error::InvalidArgumentError
  #       puts "We can't make a cache named #{cache_name}"
  #     end
  #
  #     raise error
  #   end
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
