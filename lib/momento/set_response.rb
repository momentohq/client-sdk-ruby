require_relative 'response/error'

module Momento
  # Responses specific to set.
  class SetResponse < Response
    def success?
      false
    end

    # The item was set.
    class Success < SetResponse
      attr_accessor :key, :value

      # rubocop:disable Lint/MissingSuper
      def initialize(key:, value:)
        @key = key
        @value = value

        return
      end
      # rubocop:enable Lint/MissingSuper

      def success?
        true
      end

      def to_s
        "#{super}: '#{display_string(key)}' = '#{display_string(value)}'"
      end
    end

    # There was an error setting the item.
    class Error < SetResponse
      include Momento::Response::Error
    end
  end
end
