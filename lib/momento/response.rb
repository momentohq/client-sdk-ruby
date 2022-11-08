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

    # A successful response from a gRPC call.
    class Success < Response
    end

    # Superclass for all GRPC::BadStatus responses..
    class Error < Response
      attr_accessor :grpc_exception

      # rubocop:disable Lint/MissingSuper
      def initialize(grpc_exception:)
        @grpc_exception = grpc_exception
      end
      # rubocop:enable Lint/MissingSuper
    end

    # The item already exists (GRPC::AlreadyExists)
    class AlreadyExists < Error
    end

    # The arguments were invalid (GRPC::InvalidArgument)
    class InvalidArgument < Error
    end

    # The item was not found. (GRPC::NotFound)
    class NotFound < Error
    end

    # Permission was denied to make the gRPC call.
    class PermissionDenied < Error
    end
  end
end
