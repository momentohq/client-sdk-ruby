require 'grpc'
require_relative 'cacheclient_pb'

module Momento
  # An internal class.
  #
  # Builds SetResponses
  class SetResponseBuilder < ResponseBuilder
    # Build a Momento::SetResponse from a block of code
    # which returns a Momento::CacheClient::SetResponse..
    #
    # @return [Momento::SetResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def from_block
      response = yield
    rescue GRPC::BadStatus => e
      SetResponse::Error.new(exception: e)
    else
      raise TypeError unless response.is_a?(::Momento::CacheClient::SetResponse)

      SetResponse::Success.new
    end
  end
end
