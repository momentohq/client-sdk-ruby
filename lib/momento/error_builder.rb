require 'grpc'
require_relative 'error/types'
require_relative 'exceptions'

module Momento
  # @private
  class ErrorBuilder
    EXCEPTION_MAP = {
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
      GRPC::Unknown => Error::UnknownServiceError,
      Momento::CacheNameError => Error::InvalidArgumentError
    }.freeze

    class << self
      def from_exception(exception, context: {})
        error_class = EXCEPTION_MAP[exception.class] || Error::UnknownError

        error = error_class.new
        error.context = context
        error.cause = exception

        case exception
        when GRPC::BadStatus
          error.transport_details = Error::TransportDetails.new(grpc: exception)
          error.details = exception.details
        else
          error.details = exception.message
        end

        error.freeze

        return error
      end
    end
  end
end
