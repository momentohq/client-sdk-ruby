module Momento
  class Response
    # Responses specific to get.
    module Get
      class << self
        # Build a Momento::Response::Get from a block of code
        # which returns a Momento::ControlClient::GetResponse.
        #
        # @return [Momento::Response::Get]
        # @raise [StandardError] when the exception is not recognized.
        # @raise [TypeError] when the response is not recognized.
        def from_block
          response = yield
        rescue Encoding::UndefinedConversionError, GRPC::InvalidArgument => e
          Get::Error::InvalidArgument.new(grpc_exception: e)
        rescue GRPC::NotFound => e
          Get::Error::NotFound.new(grpc_exception: e)
        rescue GRPC::PermissionDenied => e
          Get::Error::PermissionDenied.new(grpc_exception: e)
        else
          from_response(response)
        end

        private

        def from_response(response)
          raise TypeError unless response.is_a?(Momento::CacheClient::GetResponse)

          case response.result
          when :Hit
            Get::Hit.new(response)
          when :Miss
            Get::Miss.new
          else
            raise "Unknown get result: #{response.result}"
          end
        end
      end

      # A successful get from the cache.
      class Hit < Success
        # @return [String] the value from the cache
        def value
          @grpc_response.cache_body
        end

        def to_s
          value
        end
      end

      # The item was not in the cache.
      class Miss < Response
      end

      # A catch all for all Get errors.
      class Error < Error
        # Cache name is invalid.
        class InvalidArgument < Error
        end

        # Cache is not found.
        class NotFound < Error
        end

        class PermissionDenied < Error
        end
      end
    end
  end
end
