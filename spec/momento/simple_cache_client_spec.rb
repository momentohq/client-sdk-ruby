require 'momento'

RSpec.describe Momento::SimpleCacheClient do
  let(:client) { build(:momento_simple_cache_client) }

  describe '#new' do
    subject { client }

    it { is_expected.to be_a described_class }
  end

  describe '#control_stub' do
    subject(:stub) { client.send(:control_stub) }

    let(:control_client_stub_class) { described_class.const_get(:CONTROL_CLIENT_STUB_CLASS) }
    let(:control_endpoint) { Faker::Internet.domain_name }
    let(:token) { build(:auth_token, cp: control_endpoint) }
    let(:client) { build(:momento_simple_cache_client, auth_token: token) }

    it { is_expected.to be_a control_client_stub_class }

    it 'creates a control stub with the endpoint' do
      allow(control_client_stub_class).to receive(:new).and_call_original

      stub

      expect(control_client_stub_class).to have_received(:new)
        .with(control_endpoint, instance_of(GRPC::Core::ChannelCredentials))
    end
  end

  describe '#create_cache' do
    let(:cache_name) { "foobar" }
    let(:stub) { client.send(:control_stub) }

    it 'sends a CreateCacheRequest with the cache name' do
      allow(stub).to receive(:create_cache)
        .and_return(ControlClient::CreateCacheResponse.new)

      client.create_cache(cache_name)

      expect(stub).to have_received(:create_cache)
        .with(
          satisfy { |v|
            v.is_a?(ControlClient::CreateCacheRequest) && v["cache_name"] == cache_name
          }
        )
    end

    context 'when the response is a bad status' do
      let(:grpc_error) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::Response::CreateCache::InvalidArgument }

      before do
        allow(stub).to receive(:create_cache)
          .and_raise(grpc_error)
      end

      it 'returns the appropriate Response' do
        expect(client.create_cache(cache_name)).to be_a response_class
      end
    end

    context 'when the stub raises an unknown error' do
      let(:error) { StandardError.new("the front fell off") }

      before do
        allow(stub).to receive(:create_cache)
          .and_raise(error)
      end

      it 'raises the error' do
        expect {
          client.create_cache(cache_name)
        }.to raise_error(error)
      end
    end
  end

  describe '#delete_cache' do
    let(:cache_name) { "foobar" }
    let(:stub) { client.send(:control_stub) }

    it 'sends a DeleteCacheRequest with the cache name' do
      allow(stub).to receive(:delete_cache)
        .and_return(ControlClient::DeleteCacheResponse.new)

      client.delete_cache(cache_name)

      expect(stub).to have_received(:delete_cache)
        .with(
          satisfy { |v|
            v.is_a?(ControlClient::DeleteCacheRequest) && v["cache_name"] == cache_name
          }
        )
    end

    context 'when the response is a bad status' do
      let(:grpc_error) { GRPC::NotFound.new }
      let(:response_class) { Momento::Response::DeleteCache::NotFound }

      before do
        allow(stub).to receive(:delete_cache)
          .and_raise(grpc_error)
      end

      it 'returns the appropriate Response' do
        expect(client.delete_cache(cache_name)).to be_a response_class
      end
    end

    context 'when the stub raises an unknown error' do
      let(:error) { StandardError.new("the front fell off") }

      before do
        allow(stub).to receive(:delete_cache)
          .and_raise(error)
      end

      it 'raises the error' do
        expect {
          client.delete_cache(cache_name)
        }.to raise_error(error)
      end
    end
  end
end
