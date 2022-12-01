require 'grpc'
require_relative 'cacheclient_pb'

module Momento
  # Builds SetResponses
  #
  # @private
  class SetResponseBuilder < ResponseBuilder
    # Build a Momento::SetResponse from a block of code
    # which returns a Momento::CacheClient::SetResponse..
    #
    # @return [Momento::SetResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def from_block
      response = yield
    rescue *RESCUED_EXCEPTIONS => e
      SetResponse::Error.new(exception: e, context: context)
    else
      raise TypeError unless response.is_a?(::Momento::CacheClient::SetResponse)

      SetResponse::Success.new(key: context[:key], value: context[:value])
    end
  end
end
