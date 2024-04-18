require 'grpc'
require_relative 'generated/controlclient_pb'

module Momento
  # @private
  class DeleteCacheResponseBuilder < ResponseBuilder
    # Build a Momento::DeleteCacheResponse from a block of code
    # which returns a Momento::ControlClient::DeleteCacheResponse..
    #
    # @return [Momento::DeleteCacheResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def from_block
      response = yield
    rescue *RESCUED_EXCEPTIONS => e
      DeleteCacheResponse::Error.new(
        exception: e, context: context
      )
    else
      raise TypeError unless response.is_a?(::Momento::ControlClient::DeleteCacheResponse)

      return DeleteCacheResponse::Success.new
    end
  end
end
