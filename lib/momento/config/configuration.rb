module Momento
  module Cache
    # Configuration options for Momento CacheClient
    class Configuration
      attr_reader :transport_strategy

      def self.with_transport_strategy(transport_strategy)
        return Configuration.new(transport_strategy)
      end

      def initialize(transport_strategy)
        @transport_strategy = transport_strategy
      end
    end
  end
end
