require_relative 'response/error'

module Momento
  # A response from deleting a key.
  class DeleteResponse < Response
    # Was the key deleted?
    # @return [Boolean]
    def success?
      false
    end

    # @private
    class Success < DeleteResponse
      def success?
        true
      end
    end

    # @private
    class Error < DeleteResponse
      include Momento::Response::Error
    end
  end
end
