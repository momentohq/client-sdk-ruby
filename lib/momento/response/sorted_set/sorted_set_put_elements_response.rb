require_relative '../error'
require_relative '../../generated/cacheclient_pb'

module Momento
  # A response representing the result of a sorted set put elements operation.
  class SortedSetPutElementsResponse < Response
    # Were the elements added to the sorted set?
    # @return [Boolean]
    def success?
      false
    end

    # @private
    class Success < SortedSetPutElementsResponse
      def success?
        true
      end
    end

    # @private
    class Error < SortedSetPutElementsResponse
      include Momento::Response::Error
    end
  end

  # @private
  class SortedSetPutElementsResponseBuilder < ResponseBuilder
    # Build a Momento::SortedSetPutElementsResponse from a block of code
    # which returns a MomentoProtos::CacheClient::PB__SortedSetPutElementsResponse.
    #
    # @return [Momento::SortedSetPutElementsResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def from_block
      response = yield
    rescue *RESCUED_EXCEPTIONS => e
      SortedSetPutElementsResponse::Error.new(exception: e, context: context)
    else
      raise TypeError unless response.is_a?(::MomentoProtos::CacheClient::PB__SortedSetPutResponse)

      SortedSetPutElementsResponse::Success.new
    end
  end
end
