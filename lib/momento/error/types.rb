module Momento
  module Error
    # rubocop:disable Layout/LineLength

    # A cache with the specified name already exists.
    class AlreadyExistsError < RuntimeError
      include Momento::Error

      # (see Momento::Error#error_code)
      def error_code
        :ALREADY_EXISTS_ERROR
      end

      # (see Momento::Error#message)
      def message
        "A cache with the specified name already exists.  To resolve this error, either delete the existing cache and make a new one, or use a different name.  Cache name: '#{context[:cache_name]}'"
      end
    end

    # Invalid authentication credentials to connect to cache service
    class AuthenticationError < RuntimeError
      include Momento::Error

      # (see Momento::Error#error_code)
      def error_code
        :AUTHENTICATION_ERROR
      end

      # (see Momento::Error#message)
      def message
        "Invalid authentication credentials to connect to cache service: #{details}"
      end
    end

    # The request was invalid.
    class BadRequestError < RuntimeError
      include Momento::Error

      # (see Momento::Error#error_code)
      def error_code
        :BAD_REQUEST_ERROR
      end

      # (see Momento::Error#message)
      def message
        "The request was invalid; please contact Momento: #{details}"
      end
    end

    # The request was cancelled by the server.
    class CancelledError < RuntimeError
      include Momento::Error

      # (see Momento::Error#error_code)
      def error_code
        :CANCELLED_ERROR
      end

      # (see Momento::Error#message)
      def message
        "The request was cancelled by the server; please contact Momento: #{details}"
      end
    end

    # A client resource (most likely memory) was exhausted.
    class ClientResourceExhaustedError < RuntimeError
      include Momento::Error

      # (see Momento::Error#error_code)
      def error_code
        :CLIENT_RESOURCE_EXHAUSTED
      end

      # (see Momento::Error#message)
      def message
        "A client resource (most likely memory) was exhausted.  If you are executing a high volume of concurrent requests or using very large object sizes, your Configuration may need to be updated to allocate more memory.  Please contact Momento for assistance."
      end
    end

    # Error connecting to Momento servers.
    class ConnectionError < RuntimeError
      include Momento::Error

      # (see Momento::Error#error_code)
      def error_code
        :CONNECTION_ERROR
      end

      # (see Momento::Error#message)
      def message
        "Error connecting to Momento servers."
      end
    end

    # System is not in a state required for the operation\'s execution
    class FailedPreconditionError < RuntimeError
      include Momento::Error

      # (see Momento::Error#error_code)
      def error_code
        :FAILED_PRECONDITION_ERROR
      end

      # (see Momento::Error#message)
      def message
        "System is not in a state required for the operation's execution"
      end
    end

    # An unexpected error occurred while trying to fulfill the request.
    class InternalServerError < RuntimeError
      include Momento::Error

      # (see Momento::Error#error_code)
      def error_code
        :INTERNAL_SERVER_ERROR
      end

      # (see Momento::Error#message)
      def message
        "An unexpected error occurred while trying to fulfill the request; please contact Momento: #{details}"
      end
    end

    # Invalid argument passed to Momento client
    class InvalidArgumentError < ArgumentError
      include Momento::Error

      def initialize(details = "")
        @details = details
        super(message)
      end

      # (see Momento::Error#error_code)
      def error_code
        :INVALID_ARGUMENT_ERROR
      end

      attr_reader :details

      # (see Momento::Error#message)
      def message
        "Invalid argument passed to Momento client: #{details}"
      end
    end

    # Request rate exceeded the limits for this account.
    class LimitExceededError < RuntimeError
      attr_reader :details, :transport_details

      def initialize(details, transport_details)
        super()
        @details = details
        @transport_details = transport_details
      end

      # Extract the error cause from metadata
      def error_cause
        metadata = transport_details.grpc.metadata
        metadata[:err] || 'unknown_error'
      end

      class ErrorMessages
        TOPIC_SUBSCRIPTIONS_LIMIT_EXCEEDED = 'Topic subscriptions limit exceeded.'.freeze
        OPERATIONS_RATE_LIMIT_EXCEEDED = 'Operations rate limit exceeded.'.freeze
        THROUGHPUT_RATE_LIMIT_EXCEEDED = 'Throughput rate limit exceeded.'.freeze
        REQUEST_SIZE_LIMIT_EXCEEDED = 'Request size limit exceeded.'.freeze
        ITEM_SIZE_LIMIT_EXCEEDED = 'Item size limit exceeded.'.freeze
        ELEMENT_SIZE_LIMIT_EXCEEDED = 'Element size limit exceeded.'.freeze
        UNKNOWN_LIMIT_EXCEEDED = 'Limit exceeded for this account.'.freeze

        # Map error causes to the corresponding message
        ERROR_CAUSES = {
          'topic_subscriptions_limit_exceeded' => TOPIC_SUBSCRIPTIONS_LIMIT_EXCEEDED,
          'operations_rate_limit_exceeded' => OPERATIONS_RATE_LIMIT_EXCEEDED,
          'throughput_rate_limit_exceeded' => THROUGHPUT_RATE_LIMIT_EXCEEDED,
          'request_size_limit_exceeded' => REQUEST_SIZE_LIMIT_EXCEEDED,
          'item_size_limit_exceeded' => ITEM_SIZE_LIMIT_EXCEEDED,
          'element_size_limit_exceeded' => ELEMENT_SIZE_LIMIT_EXCEEDED
        }.freeze

        # Map substrings to the corresponding message
        ERROR_SUBSTRINGS = {
          'subscribers' => TOPIC_SUBSCRIPTIONS_LIMIT_EXCEEDED,
          'operations' => OPERATIONS_RATE_LIMIT_EXCEEDED,
          'throughput' => THROUGHPUT_RATE_LIMIT_EXCEEDED,
          'request limit' => REQUEST_SIZE_LIMIT_EXCEEDED,
          'item size' => ITEM_SIZE_LIMIT_EXCEEDED,
          'element size' => ELEMENT_SIZE_LIMIT_EXCEEDED
        }.freeze
      end

      # Generate the appropriate message based on the error cause or details
      def message
        # First, check for a direct match in the ERROR_CAUSES for the error cause
        message = ErrorMessages::ERROR_CAUSES[error_cause]

        # If no direct match for error cause, then check if any substring in details matches
        if message.nil?
          ErrorMessages::ERROR_SUBSTRINGS.each do |key, msg|
            return msg if details.include?(key)
          end
        end

        # Return the default message if no match is found
        message || ErrorMessages::UNKNOWN_LIMIT_EXCEEDED
      end
    end

    # A cache with the specified name does not exist.
    class NotFoundError < RuntimeError
      include Momento::Error

      # (see Momento::Error#error_code)
      def error_code
        :NOT_FOUND_ERROR
      end

      # (see Momento::Error#message)
      def message
        "A cache with the specified name does not exist.  To resolve this error, make sure you have created the cache before attempting to use it.  Cache name: '#{context[:cache_name]}'"
      end
    end

    # Insufficient permissions to perform an operation on a cache.
    class PermissionError < RuntimeError
      include Momento::Error

      # (see Momento::Error#error_code)
      def error_code
        :PERMISSION_ERROR
      end

      # (see Momento::Error#message)
      def message
        "Insufficient permissions to perform an operation on a cache: #{details}"
      end
    end

    # The server was unable to handle the request
    class ServerUnavailableError < RuntimeError
      include Momento::Error

      # (see Momento::Error#error_code)
      def error_code
        :SERVER_UNAVAILABLE
      end

      # (see Momento::Error#message)
      def message
        "The server was unable to handle the request; consider retrying.  If the error persists, please contact Momento."
      end
    end

    # The client's configured timeout was exceeded.
    class TimeoutError < RuntimeError
      include Momento::Error

      # (see Momento::Error#error_code)
      def error_code
        :TIMEOUT_ERROR
      end

      # (see Momento::Error#message)
      def message
        "The client's configured timeout was exceeded; you may need to use a Configuration with more lenient timeouts.  Timeout value: #{context[:timeout]}"
      end
    end

    # The cache service failed due to an internal error
    class UnknownError < RuntimeError
      include Momento::Error

      # (see Momento::Error#error_code)
      def error_code
        :UNKNOWN_ERROR
      end

      # (see Momento::Error#message)
      def message
        "CacheService failed due to an internal error"
      end
    end

    # The cache service failed due to an internal error
    class UnknownServiceError < RuntimeError
      include Momento::Error

      # (see Momento::Error#error_code)
      def error_code
        :UNKNOWN_SERVICE_ERROR
      end

      # (see Momento::Error#message)
      def message
        "The service returned an unknown response; please contact Momento: #{details}"
      end
    end

    # rubocop:enable Layout/LineLength
  end
end
