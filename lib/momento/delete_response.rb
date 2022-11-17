require 'grpc'
require 'momento/cacheclient_pb'

module Momento
  # Responses specific to delete.
  class DeleteResponse < Response
    def self.from_block
      response = yield
    rescue GRPC::BadStatus => e
      Error.new(grpc_exception: e)
    else
      raise TypeError unless response.is_a?(Momento::CacheClient::DeleteResponse)

      Success.new
    end

    def success?
      false
    end

    # The item was deleted from the cache.
    class Success < DeleteResponse
      def success?
        true
      end
    end

    # There was an error deleting the item from the cache.
    class Error < DeleteResponse
      include Momento::Response::Error
    end
  end
end
