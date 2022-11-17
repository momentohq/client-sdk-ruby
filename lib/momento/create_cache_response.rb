require 'grpc'
require 'momento/controlclient_pb'

module Momento
  # Responses specific to create_cache.
  class CreateCacheResponse < Response
    # Build a Momento::CreateCacheResponse from a block of code
    # which returns a Momento::ControlClient::CreateCacheResponse.
    #
    # @return [Momento::CreateCacheResponse]
    # @raise [StandardError] when the exception is not recognized.
    # @raise [TypeError] when the response is not recognized.
    def self.from_block
      response = yield
    rescue GRPC::AlreadyExists
      return AlreadyExists.new
    rescue GRPC::BadStatus => e
      Error.new(grpc_exception: e)
    else
      raise TypeError unless response.is_a?(Momento::ControlClient::CreateCacheResponse)

      return Success.new
    end

    def already_exists?
      false
    end

    def success?
      false
    end

    # A cache with that name already exists.
    class AlreadyExists < CreateCacheResponse
      def already_exists?
        true
      end
    end

    # The cache was created.
    class Success < CreateCacheResponse
      def success?
        true
      end
    end

    # There was an error creating the cache.
    class Error < CreateCacheResponse
      include ::Momento::Response::Error
    end
  end
end
