require_relative '../error'
require_relative '../../generated/cacheclient_pb'

module Momento
  # A response representing the result of a sorted set put element operation.
  class SortedSetPutElementResponse < Response
    # Was the element added to the sorted set?
    # @return [Boolean]
    def success?
      false
    end

    # @private
    class Success < SortedSetPutElementResponse
      def success?
        true
      end
    end

    # @private
    class Error < SortedSetPutElementResponse
      include Momento::Response::Error
    end
  end

  # @private
  class SortedSetPutElementResponseBuilder < ResponseBuilder
    # Build a Momento::SortedSetPutElementResponse from a block of code
    # which returns a MomentoProtos::CacheClient::PB__SortedSetPutElementResponse.
    #
    # @return [Momento::SortedSetPutElementResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def from_block
      response = yield
    rescue *RESCUED_EXCEPTIONS => e
      SortedSetPutElementResponse::Error.new(exception: e, context: context)
    else
      raise TypeError unless response.is_a?(::MomentoProtos::CacheClient::PB__SortedSetPutResponse)

      SortedSetPutElementResponse::Success.new
    end
  end
end
