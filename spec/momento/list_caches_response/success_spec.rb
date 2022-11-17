require 'momento/response'

RSpec.describe Momento::ListCachesResponse::Success do
  let(:cache_names) { ["foo", "bar", "baz"] }
  let(:next_token) { "abcd123" }
  let(:grpc_list_caches_response) {
    build(
      :momento_control_client_list_caches_response,
      cache_names: cache_names,
      next_token: next_token
    )
  }
  let(:response) {
    described_class.new(grpc_response: grpc_list_caches_response)
  }

  it_behaves_like Momento::ListCachesResponse do
    let(:types) do { success?: true } end
  end

  describe '#cache_names' do
    subject { response.cache_names }

    it { is_expected.to eq cache_names }
  end

  describe '#next_token' do
    subject { response.next_token }

    it { is_expected.to eq next_token }
  end
end
