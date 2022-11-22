require 'grpc'
require_relative 'error/types'

module Momento
  # An internal class to build Momento::Errors
  class ErrorBuilder
    GRPC_EXCEPTION_MAP = {
      GRPC::Aborted => Error::InternalServerError,
      GRPC::AlreadyExists => Error::AlreadyExistsError,
      GRPC::Cancelled => Error::CancelledError,
      GRPC::DataLoss => Error::InternalServerError,
      GRPC::DeadlineExceeded => Error::TimeoutError,
      GRPC::FailedPrecondition => Error::FailedPreconditionError,
      GRPC::Internal => Error::InternalServerError,
      GRPC::InvalidArgument => Error::InvalidArgumentError,
      GRPC::NotFound => Error::NotFoundError,
      GRPC::OutOfRange => Error::BadRequestError,
      GRPC::PermissionDenied => Error::PermissionError,
      GRPC::ResourceExhausted => Error::LimitExceededError,
      GRPC::Unauthenticated => Error::AuthenticationError,
      GRPC::Unavailable => Error::ServerUnavailableError,
      GRPC::Unimplemented => Error::BadRequestError,
      GRPC::Unknown => Error::UnknownServiceError
    }.freeze

    OTHER_EXCEPTION_MAP = {}.freeze

    class << self
      def from_exception(exception, context: {})
        new(exception: exception, context: context)
          .from_exception
      end
    end

    def initialize(exception:, context:)
      @exception = exception
      @context = context
    end

    def from_exception
      return from_grpc_exception ||
             from_other_exception ||
             from_unknown_exception
    end

    private

    def from_grpc_exception
      return unless (error_class = GRPC_EXCEPTION_MAP[@exception.class])

      return error_class.new(
        context: @context,
        exception: @exception,
        transport_metadata: @exception.metadata,
        details: @exception.details
      )
    end

    def from_other_exception
      return unless (error_class = OTHER_EXCEPTION_MAP[@exception.class])

      return error_class.new(
        context: @context,
        exception: @exception
      )
    end

    def from_unknown_exception
      return UnknownError.new(
        exception: @exception, context: @context
      )
    end
  end
end
