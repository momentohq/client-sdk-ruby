require_relative 'configuration'
require_relative 'transport/transport_strategy'
require_relative 'transport/static_transport_strategy'
require_relative 'transport/grpc_configuration'

module Momento
  module Configurations
    # Default Laptop configuration with 5000ms client timeout
    class Laptop < Configuration
      def self.latest
        return Configuration.new(
          transport_strategy: StaticTransportStrategy.new(
            grpc_configuration: GrpcConfiguration.new(deadline: 5000)
          )
        )
      end
    end
  end
end
