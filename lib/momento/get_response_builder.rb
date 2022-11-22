require_relative 'response_builder'
require_relative 'cacheclient_pb'
require_relative 'get_response'

module Momento
  # An internal class.
  #
  # Builds GetResponses
  class GetResponseBuilder < ResponseBuilder
    # Build a Momento::GetResponse from a block of code
    # which returns a Momento::ControlClient::GetResponse.
    #
    # @return [Momento::GetResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def from_block
      response = yield
    rescue GRPC::BadStatus => e
      GetResponse::Error.new(exception: e, context: context)
    else
      from_response(response)
    end

    private

    def from_response(response)
      raise TypeError unless response.is_a?(Momento::CacheClient::GetResponse)

      case response.result
      when :Hit
        GetResponse::Hit.new(grpc_response: response)
      when :Miss
        GetResponse::Miss.new
      else
        raise "Unknown get result: #{response.result}"
      end
    end
  end
end
