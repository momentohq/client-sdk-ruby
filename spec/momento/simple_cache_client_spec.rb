require 'momento'

RSpec.describe Momento::SimpleCacheClient do
  let(:client) { build(:momento_simple_cache_client) }
  let(:cache_stub) { client.send(:cache_stub) }
  let(:control_stub) { client.send(:control_stub) }

  describe '#new' do
    subject { client }

    it { is_expected.to be_a described_class }
  end

  shared_examples 'a gRPC stub' do
    subject(:stub) { client.send(stub_method) }

    let(:client) { build(:momento_simple_cache_client, auth_token: token) }
    let(:endpoint) { Faker::Internet.domain_name }

    it { is_expected.to be_a stub_class }

    it 'creates a stub with the endpoint' do
      allow(stub_class).to receive(:new).and_call_original

      stub

      expect(stub_class).to have_received(:new)
        .with(endpoint, instance_of(GRPC::Core::ChannelCredentials))
    end
  end

  describe '#cache_stub' do
    let(:stub_class) { described_class.const_get(:CACHE_CLIENT_STUB_CLASS) }
    let(:stub_method) { :cache_stub }
    let(:token) { build(:auth_token, c: endpoint) }

    it_behaves_like 'a gRPC stub'
  end

  describe '#control_stub' do
    let(:stub_class) { described_class.const_get(:CONTROL_CLIENT_STUB_CLASS) }
    let(:stub_method) { :control_stub }
    let(:token) { build(:auth_token, cp: endpoint) }

    it_behaves_like 'a gRPC stub'
  end

  describe '#create_cache' do
    let(:cache_name) { "foobar" }

    it 'sends a CreateCacheRequest with the cache name' do
      allow(control_stub).to receive(:create_cache)
        .and_return(Momento::ControlClient::CreateCacheResponse.new)

      client.create_cache(cache_name)

      expected_request = be_a(Momento::ControlClient::CreateCacheRequest).and have_attributes(
        cache_name: cache_name
      )

      expect(control_stub).to have_received(:create_cache).with(expected_request)
    end

    context 'when the response is success' do
      before do
        allow(control_stub).to receive(:create_cache)
          .and_return(Momento::ControlClient::CreateCacheResponse.new)
      end

      it 'returns the appropriate Response' do
        expect(client.create_cache(cache_name)).to be_a Momento::Response::CreateCache::Success
      end
    end

    context 'when the response is a bad status' do
      let(:grpc_error) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::Response::CreateCache::Error::InvalidArgument }

      before do
        allow(control_stub).to receive(:create_cache)
          .and_raise(grpc_error)
      end

      it 'returns the appropriate Response' do
        expect(client.create_cache(cache_name)).to be_a response_class
      end
    end

    context 'when the stub raises an unknown error' do
      let(:error) { StandardError.new("the front fell off") }

      before do
        allow(control_stub).to receive(:create_cache)
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

    it 'sends a DeleteCacheRequest with the cache name' do
      allow(control_stub).to receive(:delete_cache)
        .and_return(Momento::ControlClient::DeleteCacheResponse.new)

      client.delete_cache(cache_name)

      expected_request = be_a(Momento::ControlClient::DeleteCacheRequest).and have_attributes(
        cache_name: cache_name
      )

      expect(control_stub).to have_received(:delete_cache).with(expected_request)
    end

    context 'when the response is success' do
      before do
        allow(control_stub).to receive(:delete_cache)
          .and_return(Momento::ControlClient::DeleteCacheResponse.new)
      end

      it 'returns the appropriate Response' do
        expect(client.delete_cache(cache_name)).to be_a Momento::Response::DeleteCache::Success
      end
    end

    context 'when the response is a bad status' do
      let(:grpc_error) { GRPC::NotFound.new }
      let(:response_class) { Momento::Response::DeleteCache::Error::NotFound }

      before do
        allow(control_stub).to receive(:delete_cache)
          .and_raise(grpc_error)
      end

      it 'returns the appropriate Response' do
        expect(client.delete_cache(cache_name)).to be_a response_class
      end
    end

    context 'when the stub raises an unknown error' do
      let(:error) { StandardError.new("the front fell off") }

      before do
        allow(control_stub).to receive(:delete_cache)
          .and_raise(error)
      end

      it 'raises the error' do
        expect {
          client.delete_cache(cache_name)
        }.to raise_error(error)
      end
    end
  end

  describe '#list_caches' do
    let(:next_token) { "abc123" }

    it 'sends a ListCachesRequest with the token' do
      allow(control_stub).to receive(:list_caches)
        .and_return(build(:momento_control_client_list_caches_response))

      client.list_caches(next_token: next_token)

      expected_request = be_a(Momento::ControlClient::ListCachesRequest)
        .and have_attributes(next_token: next_token)

      expect(control_stub).to have_received(:list_caches)
        .with(expected_request)
    end

    it 'defaults to the first page' do
      allow(control_stub).to receive(:list_caches)
        .and_return(build(:momento_control_client_list_caches_response))

      client.list_caches(next_token: "")

      expected_request = be_a(Momento::ControlClient::ListCachesRequest)
        .and have_attributes(next_token: "")

      expect(control_stub).to have_received(:list_caches)
        .with(expected_request)
    end

    it 'returns Success when the response is successful' do
      allow(control_stub).to receive(:list_caches)
        .and_return(build(:momento_control_client_list_caches_response))

      expect(client.list_caches).to be_a Momento::Response::ListCaches::Caches
    end

    it 'returns an error response for a gRPC error' do
      allow(control_stub).to receive(:list_caches)
        .and_raise(GRPC::PermissionDenied.new)

      expect(client.list_caches).to be_a Momento::Response::ListCaches::Error::PermissionDenied
    end

    it 'raises on an unknown stub error' do
      stub_error = StandardError.new("the front fell off")

      allow(control_stub).to receive(:list_caches)
        .and_raise(stub_error)

      expect {
        client.list_caches
      }.to raise_error(stub_error)
    end
  end

  describe '#caches' do
    let(:grpc_responses) {
      [
        build(:momento_control_client_list_caches_response, next_token: "abc123"),
        build(:momento_control_client_list_caches_response, next_token: "")
      ]
    }

    let(:responses) {
      grpc_responses.map { |gr|
        build(:momento_response_list_caches_caches, grpc_response: gr)
      }
    }

    before do
      allow(client).to receive(:list_caches)
        .with(next_token: "").and_return(responses[0])
      allow(client).to receive(:list_caches)
        .with(next_token: responses[0].next_token).and_return(responses[1])
    end

    it 'iterates through the responses' do
      cache_names = responses.flat_map(&:cache_names)

      expect(client.caches.to_a).to eq cache_names
    end

    it 'when list_caches has an error response, it raises the grpc exception' do
      error_response = build(:momento_response_list_caches_error_permission_denied)

      allow(client).to receive(:list_caches)
        .and_return(error_response)

      expect {
        client.caches.to_a
      }.to raise_error(error_response.grpc_exception)
    end

    it 'when list_caches raises, it raises' do
      error = "the front fell off"

      allow(client).to receive(:list_caches)
        .and_raise(error)

      expect {
        client.caches.to_a
      }.to raise_error(error)
    end
  end

  describe '#get' do
    it 'sends a GetRequest with the cache name and key' do
      allow(cache_stub).to receive(:get)
        .and_return(build(:momento_cache_client_get_response, :hit))

      client.get("name", "key")

      expect(cache_stub).to have_received(:get)
        .with(
          be_a(Momento::CacheClient::GetRequest).and(have_attributes(cache_key: "key")),
          metadata: { cache: "name" }
        )
    end

    it 'with a non-ACII string it does not raise nor change the encoding' do
      allow(cache_stub).to receive(:get)
        .and_return(build(:momento_cache_client_get_response, :hit))

      key = "🫠🤢"

      expect {
        expect(
          client.get("name", key)
        ).to be_a(Momento::Response::Get::Hit)
      }.to not_change {
        key.encoding
      }
    end

    it 'with a non-ACII string it does not raise' do
      allow(cache_stub).to receive(:get)
        .and_return(build(:momento_cache_client_get_response, :hit))

      expect(
        client.get("name", "🫠🤢".freeze)
      ).to be_a(Momento::Response::Get::Hit)
    end

    context 'with a gRPC response' do
      before do
        allow(cache_stub).to receive(:get)
          .and_return(grpc_response)
      end

      context 'when it is a hit' do
        let(:grpc_response) { build(:momento_cache_client_get_response, :hit) }

        it 'returns a Get::Hit' do
          expect(
            client.get("name", "key")
          ).to be_a(Momento::Response::Get::Hit).and have_attributes(
            value: grpc_response.cache_body,
            grpc_response: grpc_response
          )
        end
      end

      context 'when it is a miss' do
        let(:grpc_response) { build(:momento_cache_client_get_response, :miss) }

        it 'returns a Get::Miss' do
          expect(
            client.get("name", "key")
          ).to be_a(Momento::Response::Get::Miss)
        end
      end
    end

    context 'with an exception' do
      before do
        allow(cache_stub).to receive(:get)
          .and_raise(exception)
      end

      context 'when it is a known exception' do
        let(:exception) { GRPC::NotFound.new }

        it 'returns the appropriate response' do
          expect(
            client.get("name", "key")
          ).to be_a(Momento::Response::Get::Error::NotFound).and have_attributes(
            grpc_exception: exception
          )
        end
      end

      context 'when it is a unknown exception' do
        let(:exception) { StandardError.new("the front fell off") }

        it 'raises' do
          expect {
            client.get("name", "key")
          }.to raise_error(exception)
        end
      end
    end
  end

  describe '#set' do
    shared_examples 'it sends a SetRequest' do
      it 'sends a SetRequest with the cache name, key, value, and ttl' do
        allow(cache_stub).to receive(:set)
          .and_return(build(:momento_cache_client_set_response))

        set_call

        request_expectation = be_a(Momento::CacheClient::SetRequest).and have_attributes(
          cache_key: "key", cache_body: "value", ttl_milliseconds: expected_ttl
        )

        expect(cache_stub).to have_received(:set)
          .with(
            request_expectation,
            metadata: { cache: "name" }
          )
      end
    end

    context 'without a ttl' do
      it_behaves_like 'it sends a SetRequest' do
        subject(:set_call) { client.set("name", "key", "value") }

        let(:expected_ttl) { client.default_ttl }
      end
    end

    context 'with a ttl' do
      it_behaves_like 'it sends a SetRequest' do
        subject(:set_call) { client.set("name", "key", "value", ttl: 1234) }

        let(:expected_ttl) { 1234 }
      end
    end

    context 'when it is a success' do
      let(:grpc_response) { build(:momento_cache_client_set_response) }

      before do
        allow(client.send(:cache_stub)).to receive(:set)
          .and_return(grpc_response)
      end

      it 'returns a Set::Success' do
        expect(
          client.set("name", "key", "value")
        ).to be_a(Momento::Response::Set::Success).and have_attributes(
          grpc_response: grpc_response
        )
      end

      context 'with a non-ASCII key and value' do
        it 'can be set' do
          key = "🫠🤢"
          value = "🎉☃"

          expect {
            expect(
              client.set("name", key, value)
            ).to be_a(Momento::Response::Set::Success)
          }.to not_change {
            value.encoding
          }.and not_change {
            key.encoding
          }
        end
      end

      context 'with a frozen non-ASCII key and value' do
        it 'can be set' do
          expect(
            client.set("name", "🫠🤢".freeze, "🎉☃".freeze)
          ).to be_a(Momento::Response::Set::Success)
        end
      end
    end

    context 'with an exception' do
      before do
        allow(client.send(:cache_stub)).to receive(:set)
          .and_raise(exception)
      end

      context 'when it is a known exception' do
        let(:exception) { GRPC::NotFound.new }

        it 'returns the appropriate response' do
          expect(
            client.set("name", "key", "value")
          ).to be_a(Momento::Response::Set::Error::NotFound).and have_attributes(
            grpc_exception: exception
          )
        end
      end

      context 'when it is a unknown exception' do
        let(:exception) { StandardError.new("the front fell off") }

        it 'raises' do
          expect {
            client.set("name", "key", "value")
          }.to raise_error(exception)
        end
      end
    end
  end

  describe '#delete' do
    it 'sends a DeleteRequest with the cache name and key' do
      allow(cache_stub).to receive(:delete)
        .and_return(build(:momento_cache_client_delete_response))

      client.delete("name", "key")

      expect(cache_stub).to have_received(:delete)
        .with(
          be_a(Momento::CacheClient::DeleteRequest).and(have_attributes(cache_key: "key")),
          metadata: { cache: "name" }
        )
    end

    it 'with a non-ACII string it does not raise nor change the encoding' do
      allow(cache_stub).to receive(:delete)
        .and_return(build(:momento_cache_client_delete_response))

      key = "🫠🤢"

      expect {
        expect(
          client.delete("name", key)
        ).to be_a(Momento::Response::Delete::Success)
      }.to not_change {
        key.encoding
      }
    end

    it 'with a non-ACII string it does not raise' do
      allow(cache_stub).to receive(:delete)
        .and_return(build(:momento_cache_client_delete_response))

      expect(
        client.delete("name", "🫠🤢".freeze)
      ).to be_a(Momento::Response::Delete::Success)
    end

    context 'when it is a success' do
      let(:grpc_response) { build(:momento_cache_client_delete_response) }

      before do
        allow(client.send(:cache_stub)).to receive(:delete)
          .and_return(grpc_response)
      end

      it 'returns a Delete::Response' do
        expect(
          client.delete("name", "key")
        ).to be_a(Momento::Response::Delete::Success).and have_attributes(
          grpc_response: grpc_response
        )
      end
    end

    context 'with an exception' do
      before do
        allow(client.send(:cache_stub)).to receive(:delete)
          .and_raise(exception)
      end

      context 'when it is a known exception' do
        let(:exception) { GRPC::NotFound.new }

        it 'returns the appropriate response' do
          expect(
            client.delete("name", "key")
          ).to be_a(Momento::Response::Delete::Error::NotFound).and have_attributes(
            grpc_exception: exception
          )
        end
      end

      context 'when it is a unknown exception' do
        let(:exception) { StandardError.new("the front fell off") }

        it 'raises' do
          expect {
            client.delete("name", "key")
          }.to raise_error(exception)
        end
      end
    end
  end
end
