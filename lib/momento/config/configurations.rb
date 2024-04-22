require_relative 'configuration'
require_relative 'transport/transport_strategy'
require_relative 'transport/static_transport_strategy'
require_relative 'transport/grpc_configuration'

module Momento
  module Cache
    module Configurations
      # Default Laptop configuration with 5000ms client timeout
      class Laptop < Cache::Configuration
        def self.latest
          return Configuration.new(StaticTransportStrategy.new(GrpcConfiguration.new(5000)))
        end
      end
    end
  end
end
