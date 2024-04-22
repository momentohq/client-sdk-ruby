require "momento/config/configuration"
require "momento/config/transport/static_transport_strategy"
require "momento/config/transport/grpc_configuration"

RSpec.describe Momento::Cache::Configuration do
  describe "cache configuration" do
    context "when given a negative client timeout" do
      it "raises an InvalidArgumentError" do
        expect {
          described_class.new(Momento::StaticTransportStrategy.new(Momento::GrpcConfiguration.new(-10)))
        }.to raise_error(Momento::Error::InvalidArgumentError)
      end
    end

    context "when given a positive client timeout" do
      it "raises an InvalidArgumentError" do
        config = described_class.new(Momento::StaticTransportStrategy.new(Momento::GrpcConfiguration.new(1000)))
        expect(config.transport_strategy.grpc_configuration.deadline).to eq(1000)
      end
    end
  end
end
