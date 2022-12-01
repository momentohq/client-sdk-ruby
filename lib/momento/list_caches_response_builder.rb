require 'grpc'
require_relative 'controlclient_pb'

module Momento
  # @private
  class ListCachesResponseBuilder < ResponseBuilder
    # Build a Momento::ListCachesResponse from a block of code
    # which returns a Momento::ControlClient::ListCachesResponse..
    #
    # @return [Momento::ListCachesResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def from_block
      response = yield
    rescue GRPC::BadStatus => e
      ListCachesResponse::Error.new(
        exception: e, context: context
      )
    else
      raise TypeError unless response.is_a?(::Momento::ControlClient::ListCachesResponse)

      return ListCachesResponse::Success.new(grpc_response: response)
    end
  end
end
