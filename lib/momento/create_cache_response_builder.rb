require 'grpc'
require_relative 'controlclient_pb'

module Momento
  # An internal class.
  #
  # Builds CreateCacheResponses
  class CreateCacheResponseBuilder < ResponseBuilder
    # Build a Momento::CreateCacheResponse from a block of code
    # which returns a Momento::ControlClient::CreateCacheResponse.
    #
    # @return [Momento::CreateCacheResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def from_block
      response = yield
    rescue GRPC::AlreadyExists
      return CreateCacheResponse::AlreadyExists.new
    rescue GRPC::BadStatus => e
      CreateCacheResponse::Error.new(grpc_exception: e)
    else
      raise TypeError unless response.is_a?(::Momento::ControlClient::CreateCacheResponse)

      return CreateCacheResponse::Success.new
    end
  end
end
