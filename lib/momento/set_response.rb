require_relative 'response/error'

module Momento
  # A response from setting a key.
  class SetResponse < Response
    # Was the key/value pair added to the cache?
    # @return [Boolean]
    def success?
      false
    end

    # @private
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

    # @private
    class Error < SetResponse
      include Momento::Response::Error
    end
  end
end
