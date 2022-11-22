require_relative 'response/error'

module Momento
  # Responses specific to delete.
  class DeleteResponse < Response
    def success?
      false
    end

    # The item was deleted from the cache.
    class Success < DeleteResponse
      def success?
        true
      end
    end

    # There was an error deleting the item from the cache.
    class Error < DeleteResponse
      include Momento::Response::Error
    end
  end
end
