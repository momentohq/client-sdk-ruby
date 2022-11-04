# frozen_string_literal: true

RSpec.describe "Generated gRPC classes" do
  it "loads" do
    require "controlclient_services_pb"
    require "cacheclient_services_pb"
  end
end
