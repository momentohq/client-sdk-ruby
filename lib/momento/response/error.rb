module Momento
  class Response
    # A module for responses which contain errors.
    # @private
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

      def to_s
        "#{super}: #{error.message}"
      end
    end
  end
end
