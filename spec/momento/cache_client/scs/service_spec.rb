RSpec.describe 'CacheClient::Scs::Service' do
  it "loads" do
    expect {
      require "momento/cacheclient_services_pb"
    }.not_to raise_error
  end
end
