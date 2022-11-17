require 'grpc'
require 'momento/cacheclient_pb'

module Momento
  # Responses specific to set.
  class SetResponse < Response
    # Build a Momento::SetResponse from a block of code
    # which returns a Momento::ControlClient::SetResponse.
    #
    # @return [Momento::SetResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def self.from_block
      response = yield
    rescue GRPC::BadStatus => e
      Error.new(grpc_exception: e)
    else
      raise TypeError unless response.is_a?(Momento::CacheClient::SetResponse)

      Success.new
    end

    def success?
      false
    end

    # The item was set.
    class Success < SetResponse
      def success?
        true
      end
    end

    # There was an error setting the item.
    class Error < SetResponse
      include Momento::Response::Error
    end
  end
end
