require 'momento/response'

RSpec.describe Momento::GetResponse::Hit do
  let(:grpc_response) {
    build(:momento_cache_client_get_response, :hit)
  }
  let(:response) {
    build(:momento_get_response_hit, grpc_response: grpc_response)
  }

  it_behaves_like Momento::GetResponse do
    let(:types) do
      { hit?: true }
    end
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
