require 'grpc'

module Momento
  # A wrapper around Momento gRPC responses.
  class Response
    # See GRPC::Core::StatusCodes.constants for all possible responses.
    # The rest will be added later.
    #
    # rubocop:disable Metrics/MethodLength
    def self.wrap_grpc_exception(grpc_exception)
      case grpc_exception
      when GRPC::AlreadyExists
        Response::AlreadyExists.new(grpc_exception: grpc_exception)
      when GRPC::InvalidArgument
        Response::InvalidArgument.new(grpc_exception: grpc_exception)
      when GRPC::NotFound
        Response::NotFound.new(grpc_exception: grpc_exception)
      when GRPC::PermissionDenied
        Response::PermissionDenied.new(grpc_exception: grpc_exception)
      else
        raise "Unknown GRPC exception: #{grpc_exception}"
      end
    end
    # rubocop:enable Metrics/MethodLength

    def success?
      false
    end

    def as_success
      return self if success?
    end

    # A successful response from a gRPC call.
    class Success < Response
      def success?
        true
      end
    end

    def error?
      false
    end

    def as_error
      return self if error?
    end

    # Superclass for all GRPC::BadStatus responses..
    class Error < Response
      attr_accessor :grpc_exception

      # rubocop:disable Lint/MissingSuper
      def initialize(grpc_exception:)
        @grpc_exception = grpc_exception
      end
      # rubocop:enable Lint/MissingSuper

      def error?
        true
      end
    end

    def already_exists?
      false
    end

    def as_already_exists
      return self if already_exists?
    end

    # The item already exists (GRPC::AlreadyExists)
    class AlreadyExists < Error
      def already_exists?
        true
      end
    end

    def invalid_argument?
      false
    end

    def as_invalid_argument
      return self if invalid_argument?
    end

    # The arguments were invalid (GRPC::InvalidArgument)
    class InvalidArgument < Error
      def invalid_argument?
        true
      end
    end

    def as_not_found
      return self if not_found?
    end

    def not_found?
      false
    end

    # The item was not found. (GRPC::NotFound)
    class NotFound < Error
      def not_found?
        true
      end
    end

    def as_permission_denied
      return self if permission_denied?
    end

    def permission_denied?
      false
    end

    # Permission was denied to make the gRPC call.
    class PermissionDenied < Error
      def permission_denied?
        true
      end
    end
  end
end
