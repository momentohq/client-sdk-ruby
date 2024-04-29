require_relative '../error'
require_relative '../../generated/controlclient_pb'

module Momento
  # A response from creating a cache.
  class CreateCacheResponse < Response
    # Does the cache already exist?
    # @return [Boolean]
    def already_exists?
      false
    end

    # Was the cache created?
    # @return [Boolean]
    def success?
      false
    end

    # @private
    class AlreadyExists < CreateCacheResponse
      def already_exists?
        true
      end
    end

    # @private
    class Success < CreateCacheResponse
      def success?
        true
      end
    end

    # @private
    class Error < CreateCacheResponse
      include ::Momento::Response::Error
    end
  end

  # @private
  class CreateCacheResponseBuilder < ResponseBuilder
    # Build a Momento::CreateCacheResponse from a block of code
    # which returns a Momento::ControlClient::CreateCacheResponse.
    #
    # @return [Momento::CreateCacheResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def from_block
      response = yield
    rescue GRPC::AlreadyExists
      return CreateCacheResponse::AlreadyExists.new
    rescue *RESCUED_EXCEPTIONS => e
      CreateCacheResponse::Error.new(
        exception: e, context: context
      )
    else
      raise TypeError unless response.is_a?(::MomentoProtos::ControlClient::PB__CreateCacheResponse)

      return CreateCacheResponse::Success.new
    end
  end
end
