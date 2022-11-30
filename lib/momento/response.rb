require 'grpc'
require_relative 'response/error'
require_relative 'error'
require_relative 'error/grpc_details'
require_relative 'error/transport_details'
require_relative 'error_builder'
require_relative 'response_builder'
require_relative 'create_cache_response'
require_relative 'create_cache_response_builder'
require_relative 'delete_response'
require_relative 'delete_response_builder'
require_relative 'delete_cache_response'
require_relative 'delete_cache_response_builder'
require_relative 'get_response'
require_relative 'get_response_builder'
require_relative 'list_caches_response'
require_relative 'list_caches_response_builder'
require_relative 'set_response'
require_relative 'set_response_builder'

module Momento
  # A superclass for all Momento responses.
  class Response
    MAX_STRING_DISPLAY_LENGTH = 32
    private_constant :MAX_STRING_DISPLAY_LENGTH

    # Returns the error portion of the response, if any.
    #
    # @return [Momento::Error, nil]
    def error
      nil
    end

    # Is the response an error?
    #
    # @return [Boolean]
    def error?
      false
    end

    # Displays the type of response and additional info, if any.
    # @return [String]
    def to_s
      self.class.to_s
    end

    protected

    def display_string(string, max_length: MAX_STRING_DISPLAY_LENGTH)
      if string.length < max_length
        string
      else
        "#{string[0, max_length]}..."
      end
    end
  end
end
