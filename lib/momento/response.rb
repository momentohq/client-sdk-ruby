require 'grpc'
require_relative 'response/error'
require_relative 'response/create_cache'
require_relative 'response/delete_cache'

module Momento
  # A superclass for all momento responses.
  class Response
  end
end
