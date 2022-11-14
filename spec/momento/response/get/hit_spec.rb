require 'momento/response'
require 'momento/cacheclient_pb'

RSpec.describe Momento::Response::Get::Hit do
  let(:grpc_response) {
    build(:momento_cache_client_get_response, :hit)
  }
  let(:response) {
    described_class.new(grpc_response)
  }

  it 'is an OK response' do
    expect(response).to be_a Momento::Response::Success
  end

  describe '#value' do
    subject { response.value }

    it { is_expected.to eq grpc_response.cache_body }
  end

  describe '#to_s' do
    subject { response.to_s }

    it { is_expected.to eq response.value }
  end
end
