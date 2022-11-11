require 'grpc'
require_relative 'response/error'
require_relative 'response/create_cache'
require_relative 'response/delete_cache'
require_relative 'response/list_caches'

module Momento
  # A superclass for all Momento responses.
  # rubocop:disable Lint/EmptyClass
  class Response
  end
  # rubocop:enable Lint/EmptyClass
end
