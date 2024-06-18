require_relative 'transport_strategy'

module Momento
  # Predefined transport strategy for communicating with the Momento server
  class StaticTransportStrategy < TransportStrategy
    attr_reader :grpc_configuration

    def with_grpc_configuration(grpc_configuration)
      return StaticTransportStrategy.new(grpc_configuration)
    end
  end
end
