require 'momento'

RSpec.describe Momento::Response::ListCaches do
  it_behaves_like 'it handles unexpected exceptions'

  describe '.build_response' do
    context 'when it is PermissionDenied' do
      let(:grpc_exception) { GRPC::PermissionDenied.new }
      let(:response_class) { Momento::Response::ListCaches::PermissionDenied }

      it_behaves_like 'it wraps GRPC exceptions'
    end

    context 'when the exception is unexpected' do
      let(:grpc_exception) { instance_double(StandardError) }

      it 'raises' do
        expect {
          described_class.build_response(grpc_exception)
        }.to raise_error(/Unknown GRPC exception/)
      end
    end
  end

  describe Momento::Response::ListCaches::Caches do
    let(:cache_names) { ["foo", "bar", "baz"] }
    let(:next_token) { "abcd123" }
    let(:grpc_list_caches_response) {
      build(
        :momento_control_client_list_caches_response,
        cache_names: cache_names,
        next_token: next_token
      )
    }
    let(:response) { described_class.new(grpc_list_caches_response) }

    describe '#cache_names' do
      subject { response.cache_names }

      it { is_expected.to eq cache_names }
    end

    describe '#next_token' do
      subject { response.next_token }

      it { is_expected.to eq next_token }
    end
  end
end
