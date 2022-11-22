require_relative 'response/error'

module Momento
  # Responses specific to set.
  class SetResponse < Response
    def success?
      false
    end

    # The item was set.
    class Success < SetResponse
      def success?
        true
      end
    end

    # There was an error setting the item.
    class Error < SetResponse
      include Momento::Response::Error
    end
  end
end
