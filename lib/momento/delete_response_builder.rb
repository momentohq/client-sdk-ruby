require 'grpc'
require_relative 'cacheclient_pb'

module Momento
  # An internal class.
  #
  # Builds DeleteResponses
  class DeleteResponseBuilder < ResponseBuilder
    # Build a Momento::DeleteResponse from a block of code
    # which returns a Momento::CacheClient::DeleteResponse..
    #
    # @return [Momento::DeleteResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def from_block
      response = yield
    rescue GRPC::BadStatus => e
      DeleteResponse::Error.new(exception: e, context: context)
    else
      raise TypeError unless response.is_a?(::Momento::CacheClient::DeleteResponse)

      DeleteResponse::Success.new
    end
  end
end
