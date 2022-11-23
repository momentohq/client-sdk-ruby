module Momento
  class Error
    # rubocop:disable Layout/LineLength

    # A cache with the specified name already exists.
    class AlreadyExistsError < Error
      def error_code
        :ALREADY_EXISTS_ERROR
      end

      def message
        "A cache with the specified name already exists.  To resolve this error, either delete the existing cache and make a new one, or use a different name.  Cache name: '#{context[:cache_name]}'"
      end
    end

    # Invalid authentication credentials to connect to cache service
    class AuthenticationError < Error
      def error_code
        :AUTHENTICATION_ERROR
      end

      def message
        "Invalid authentication credentials to connect to cache service: #{details}"
      end
    end

    # The request was invalid.
    class BadRequestError < Error
      def error_code
        :BAD_REQUEST_ERROR
      end

      def message
        "The request was invalid; please contact Momento: #{details}"
      end
    end

    # The request was cancelled by the server.
    class CancelledError < Error
      def error_code
        :CANCELLED_ERROR
      end

      def message
        "The request was cancelled by the server; please contact Momento: #{details}"
      end
    end

    # A client resource (most likely memory) was exhausted.
    class ClientResourceExhaustedError < Error
      def error_code
        :CLIENT_RESOURCE_EXHAUSTED
      end

      def message
        "A client resource (most likely memory) was exhausted.  If you are executing a high volume of concurrent requests or using very large object sizes, your Configuration may need to be updated to allocate more memory.  Please contact Momento for assistance."
      end
    end

    # System is not in a state required for the operation\'s execution
    class FailedPreconditionError < Error
      def error_code
        :FAILED_PRECONDITION_ERROR
      end

      def message
        "System is not in a state required for the operation's execution"
      end
    end

    # An unexpected error occurred while trying to fulfill the request.
    class InternalServerError < Error
      def error_code
        :INTERNAL_SERVER_ERROR
      end

      def message
        "An unexpected error occurred while trying to fulfill the request; please contact Momento: #{details}"
      end
    end

    # Invalid argument passed to Momento client
    class InvalidArgumentError < Error
      def error_code
        :INVALID_ARGUMENT_ERROR
      end

      def message
        "Invalid argument passed to Momento client: #{details}"
      end
    end

    # Request rate exceeded the limits for this account.
    class LimitExceededError < Error
      def error_code
        :LIMIT_EXCEEDED_ERROR
      end

      def message
        "Request rate exceeded the limits for this account.  To resolve this error, reduce your request rate, or contact Momento to request a limit increase."
      end
    end

    # A cache with the specified name does not exist.
    class NotFoundError < Error
      def error_code
        :NOT_FOUND_ERROR
      end

      def message
        "A cache with the specified name does not exist.  To resolve this error, make sure you have created the cache before attempting to use it.  Cache name: '#{context[:cache_name]}'"
      end
    end

    # Insufficient permissions to perform an operation on a cache.
    class PermissionError < Error
      def error_code
        :PERMISSION_ERROR
      end

      def message
        "Insufficient permissions to perform an operation on a cache: #{details}"
      end
    end

    # The server was unable to handle the request
    class ServerUnavailableError < Error
      def error_code
        :SERVER_UNAVAILABLE
      end

      def message
        "The server was unable to handle the request; consider retrying.  If the error persists, please contact Momento."
      end
    end

    # The client's configured timeout was exceeded.
    class TimeoutError < Error
      def error_code
        :TIMEOUT_ERROR
      end

      def message
        "The client's configured timeout was exceeded; you may need to use a Configuration with more lenient timeouts.  Timeout value: #{context[:timeout]}"
      end
    end

    # The cache service failed due to an internal error
    class UnknownError < Error
      def error_code
        :UNKNOWN_ERROR
      end

      def message
        "CacheService failed due to an internal error"
      end
    end

    # The cache service failed due to an internal error
    class UnknownServiceError < Error
      def error_code
        :UNKNOWN_SERVICE_ERROR
      end

      def message
        "The service returned an unknown response; please contact Momento: #{details}"
      end
    end

    # rubocop:enable Layout/LineLength
  end
end
