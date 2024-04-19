module Momento
  # Low-level gRPC settings for communication with the Momento server
  class TransportStrategy
    attr_reader :grpc_configuration

    def self.with_grpc_configuration(grpc_configuration)
      return TransportStrategy.new(grpc_configuration: grpc_configuration)
    end

    def initialize(grpc_configuration)
      @grpc_configuration = grpc_configuration
    end
  end
end
