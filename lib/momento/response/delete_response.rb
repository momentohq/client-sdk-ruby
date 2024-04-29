require_relative 'error'
require 'grpc'
require_relative '../generated/cacheclient_pb'

module Momento
  # A response from deleting a key.
  class DeleteResponse < Response
    # Was the key deleted?
    # @return [Boolean]
    def success?
      false
    end

    # @private
    class Success < DeleteResponse
      def success?
        true
      end
    end

    # @private
    class Error < DeleteResponse
      include Momento::Response::Error
    end
  end

  # @private
  class DeleteResponseBuilder < ResponseBuilder
    # Build a Momento::DeleteResponse from a block of code
    # which returns a Momento::CacheClient::DeleteResponse..
    #
    # @return [Momento::DeleteResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def from_block
      response = yield
    rescue *RESCUED_EXCEPTIONS => e
      DeleteResponse::Error.new(exception: e, context: context)
    else
      raise TypeError unless response.is_a?(::MomentoProtos::CacheClient::PB__DeleteResponse)

      DeleteResponse::Success.new
    end
  end
end
