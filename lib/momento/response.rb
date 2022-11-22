require 'grpc'
require_relative 'response/error'
require_relative 'error'
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
    # Returns the error portion of the response, if any.
    #
    # @return [Momento::Error, nil]
    def error
      nil
    end

    # Is the response an error?
    def error?
      false
    end
  end
end
