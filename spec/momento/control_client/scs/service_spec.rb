RSpec.describe 'ControlClient::Scs::Service' do
  it "loads" do
    expect {
      require "momento/generated/controlclient_services_pb"
    }.not_to raise_error
  end
end
