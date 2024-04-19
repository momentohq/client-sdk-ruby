require 'grpc'
require_relative 'generated/controlclient_pb'

module Momento
  # @private
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
    rescue *RESCUED_EXCEPTIONS => e
      CreateCacheResponse::Error.new(
        exception: e, context: context
      )
    else
      raise TypeError unless response.is_a?(::MomentoProtos::ControlClient::PB__CreateCacheResponse)

      return CreateCacheResponse::Success.new
    end
  end
end
