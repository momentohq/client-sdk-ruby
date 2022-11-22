require 'grpc'
require_relative 'response/error'
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
require_relative 'set_response'
require_relative 'set_response_builder'

module Momento
  # A superclass for all Momento responses.
  class Response
    def error?
      false
    end
  end
end
