require 'grpc'
require 'momento/controlclient_pb'

module Momento
  # Responses specific to delete_cache
  class DeleteCacheResponse < Response
    # Build a Momento::DeleteCacheResponse from a block of code
    # which returns a Momento::ControlClient::DeleteCacheResponse..
    #
    # @return [Momento::DeleteCacheResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def self.from_block
      response = yield
    rescue GRPC::BadStatus => e
      Error.new(grpc_exception: e)
    else
      raise TypeError unless response.is_a?(Momento::ControlClient::DeleteCacheResponse)

      return Success.new
    end

    def success?
      false
    end

    # There was an error deleting the cache.
    class Error < DeleteCacheResponse
      include ::Momento::Response::Error
    end

    # The cache was deleted.
    class Success < DeleteCacheResponse
      def success?
        true
      end
    end
  end
end
