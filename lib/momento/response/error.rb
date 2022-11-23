module Momento
  class Response
    # A module for responses which contain errors.
    module Error
      attr_reader :error

      def initialize(exception:, context: {})
        @error = Momento::ErrorBuilder.from_exception(
          exception, context: context
        ).freeze
      end

      def error?
        true
      end
    end
  end
end
