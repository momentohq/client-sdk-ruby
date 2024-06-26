module Momento
  module Cache
    # Configuration options for Momento CacheClient
    class Configuration
      attr_reader :transport_strategy

      # Convenience function to set the client timeout in milliseconds. If the server has not responded within the
      # specified time, the client will terminate the request with a DeadlineExceeded error.
      def with_timeout(timeout_millis)
        transport_strategy = @transport_strategy
        grpc_config = transport_strategy.grpc_configuration
        Configuration.new(
          transport_strategy.with_grpc_configuration(
            grpc_config.with_deadline(timeout_millis)
          )
        )
      end

      # Convenience function to set the number of TCP connections for the client. Each connection can multiplex up
      # to 100 concurrent requests. The default is 1, and this should not be overridden unless you are making a high
      # volume of requests. Can help distribute traffic more evenly for high-throughput use cases.
      def with_num_connections(num_connections)
        transport_strategy = @transport_strategy
        grpc_config = transport_strategy.grpc_configuration
        Configuration.new(
          transport_strategy.with_grpc_configuration(
            grpc_config.with_num_grpc_channels(num_connections)
          )
        )
      end

      # Copy constructor; creates a new Configuration with the specified transport strategy
      def with_transport_strategy(transport_strategy)
        Configuration.new(transport_strategy)
      end

      def initialize(transport_strategy)
        @transport_strategy = transport_strategy
      end
    end
  end
end
