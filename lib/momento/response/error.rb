module Momento
  class Response
    # A module for responses which contain errors.
    module Error
      attr_reader :exception

      def initialize(exception:, context: {})
        @exception = exception
      end

      def error?
        true
      end
    end
  end
end
