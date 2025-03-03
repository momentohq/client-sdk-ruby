require 'momento'

RSpec.describe Momento::CacheClient do
  let(:client) { build(:momento_cache_client) }
  let(:cache_stub) { client.send(:cache_stub) }
  let(:control_stub) { client.send(:control_stub) }

  describe '#new' do
    subject { client }

    it { is_expected.to be_a described_class }

    context 'with a bad ttl' do
      let(:client) {
        build(:momento_cache_client, default_ttl: "whatever")
      }

      it {
        expect { subject }.to raise_error(ArgumentError, /is not Numeric/)
      }
    end
  end

  shared_examples 'a gRPC stub for a data client' do
    subject(:stub) { client.send(stub_method) }

    let(:client) {
      build(:momento_cache_client, credential_provider: build(:credential_provider, api_key: token),
        configuration: build(:configuration)
      )
    }
    let(:endpoint) { Faker::Internet.domain_name }

    it { is_expected.to be_a stub_class }

    it 'creates a stub with the endpoint' do
      allow(stub_class).to receive(:new).and_call_original

      stub

      expect(stub_class).to have_received(:new)
        .with(endpoint, instance_of(GRPC::Core::ChannelCredentials), { timeout: 5000,
channel_args: { "grpc.use_local_subchannel_pool" => 1, "grpc.service_config_disable_resolution" => 1 } }
        )
    end
  end

  shared_examples 'a gRPC stub for a control client' do
    subject(:stub) { client.send(stub_method) }

    let(:client) {
      build(:momento_cache_client, credential_provider: build(:credential_provider, api_key: token),
        configuration: build(:configuration)
      )
    }
    let(:endpoint) { Faker::Internet.domain_name }

    it { is_expected.to be_a stub_class }

    it 'creates a stub with the endpoint' do
      allow(stub_class).to receive(:new).and_call_original

      stub

      expect(stub_class).to have_received(:new)
        .with(endpoint, instance_of(GRPC::Core::ChannelCredentials),
              channel_args: {"grpc.service_config_disable_resolution" => 1 }
        )
    end
  end

  shared_examples 'it validates the key' do
    context 'with a non-String key' do
      let(:key) { 42 }

      it 'raises TypeError' do
        expect {
          subject
        }.to raise_error(TypeError, /expected a String, got a Integer/)
      end
    end

    context 'when a nil key' do
      let(:key) { nil }

      it 'raises TypeError' do
        expect {
          subject
        }.to raise_error(TypeError, /expected a String, got a NilClass/)
      end
    end
  end

  shared_examples 'it validates the value' do
    context 'with a non-String value' do
      let(:value) { 42 }

      it 'raises TypeError' do
        expect {
          subject
        }.to raise_error(TypeError, /expected a String, got a Integer/)
      end
    end

    context 'when a nil value' do
      let(:value) { nil }

      it 'raises TypeError' do
        expect {
          subject
        }.to raise_error(TypeError, /expected a String, got a NilClass/)
      end
    end
  end

  shared_examples 'it validates the cache name' do
    context 'when the cache_name is nil' do
      let(:cache_name) { nil }

      it {
        expect {
          subject
        }.to raise_error(TypeError, /Cache name must be a String, got a NilClass/)
      }
    end

    context 'when the cache_name is not a String' do
      let(:cache_name) { 42 }

      it {
        expect {
          subject
        }.to raise_error(TypeError, /Cache name must be a String, got a Integer/)
      }
    end

    context 'with a non-UTF-8 compatible cache name' do
      let(:cache_name) { "\xFF" }

      it {
        is_expected.to have_attributes(
          error?: true,
          error: have_attributes(
            error_code: :INVALID_ARGUMENT_ERROR
          )
        )
      }
    end
  end

  describe '#cache_stub' do
    let(:stub_class) { described_class.const_get(:CACHE_CLIENT_STUB_CLASS) }
    let(:stub_method) { :cache_stub }
    let(:token) { build(:auth_token, c: endpoint) }

    it_behaves_like 'a gRPC stub for a data client'
  end

  describe '#control_stub' do
    let(:stub_class) { described_class.const_get(:CONTROL_CLIENT_STUB_CLASS) }
    let(:stub_method) { :control_stub }
    let(:token) { build(:auth_token, cp: endpoint) }

    it_behaves_like 'a gRPC stub for a control client'
  end

  describe '#create_cache' do
    subject { client.create_cache(cache_name) }

    let(:cache_name) { Faker::Lorem.word }

    it_behaves_like 'it validates the cache name'

    it 'sends a CreateCacheRequest with the cache name' do
      allow(control_stub).to receive(:create_cache)
        .and_return(MomentoProtos::ControlClient::PB__CreateCacheResponse.new)

      subject

      expected_request = be_a(MomentoProtos::ControlClient::PB__CreateCacheRequest).and have_attributes(
        cache_name: cache_name
      )

      expect(control_stub).to have_received(:create_cache).with(expected_request)
    end

    context 'when the response is success' do
      before do
        allow(control_stub).to receive(:create_cache)
          .and_return(MomentoProtos::ControlClient::PB__CreateCacheResponse.new)
      end

      it 'returns the appropriate Response' do
        expect(subject).to be_a Momento::CreateCacheResponse::Success
      end
    end

    context 'when the response is a bad status' do
      let(:grpc_error) { GRPC::InvalidArgument.new }

      before do
        allow(control_stub).to receive(:create_cache)
          .and_raise(grpc_error)
      end

      it 'returns an error response' do
        response = subject

        expect(response.error?).to be true
        expect(response.error).to be_a_momento_error
          .with_context({ cache_name: cache_name })
          .with_grpc_exception(grpc_error)
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
          subject
        }.to raise_error(error)
      end
    end
  end

  describe '#delete_cache' do
    subject { client.delete_cache(cache_name) }

    let(:cache_name) { Faker::Lorem.word }

    it_behaves_like 'it validates the cache name'

    it 'sends a DeleteCacheRequest with the cache name' do
      allow(control_stub).to receive(:delete_cache)
        .and_return(MomentoProtos::ControlClient::PB__DeleteCacheResponse.new)

      subject

      expected_request = be_a(MomentoProtos::ControlClient::PB__DeleteCacheRequest).and have_attributes(
        cache_name: cache_name
      )

      expect(control_stub).to have_received(:delete_cache).with(expected_request)
    end

    context 'when the response is success' do
      before do
        allow(control_stub).to receive(:delete_cache)
          .and_return(MomentoProtos::ControlClient::PB__DeleteCacheResponse.new)
      end

      it 'returns the appropriate Response' do
        expect(subject).to be_a Momento::DeleteCacheResponse::Success
      end
    end

    context 'when the response is a bad status' do
      let(:grpc_error) { GRPC::NotFound.new }

      before do
        allow(control_stub).to receive(:delete_cache)
          .and_raise(grpc_error)
      end

      it 'returns an error response' do
        response = subject

        expect(response.error?).to be true
        expect(response.error).to be_a_momento_error
          .with_context({ cache_name: cache_name })
          .with_grpc_exception(grpc_error)
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
          subject
        }.to raise_error(error)
      end
    end
  end

  describe '#list_caches' do
    it 'sends a ListCachesRequest' do
      allow(control_stub).to receive(:list_caches)
        .and_return(build(:momento_control_client_list_caches_response))

      client.list_caches

      expected_request = be_a(MomentoProtos::ControlClient::PB__ListCachesRequest)

      expect(control_stub).to have_received(:list_caches)
        .with(expected_request)
    end

    it 'returns Success when the response is successful' do
      allow(control_stub).to receive(:list_caches)
        .and_return(build(:momento_control_client_list_caches_response))

      expect(client.list_caches).to be_a Momento::ListCachesResponse::Success
    end

    context 'when the response is a GRPC error' do
      let(:grpc_error) { GRPC::PermissionDenied.new }

      before {
        allow(control_stub).to receive(:list_caches)
          .and_raise(grpc_error)
      }

      it 'returns an error response for a gRPC error' do
        response = client.list_caches

        expect(response.error?).to be true
        expect(response.error).to be_a_momento_error
          .with_context({})
          .with_grpc_exception(grpc_error)
      end
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

  describe '#get' do
    subject { client.get(cache_name, key) }

    let(:cache_name) { Faker::Lorem.word }
    let(:key) { Faker::Lorem.word }

    it_behaves_like 'it validates the key'
    it_behaves_like 'it validates the cache name'

    it 'sends a GetRequest with the cache name and key' do
      allow(cache_stub).to receive(:get)
        .and_return(build(:momento_cache_client_get_response, :hit))

      subject

      expect(cache_stub).to have_received(:get)
        .with(
          be_a(MomentoProtos::CacheClient::PB__GetRequest).and(have_attributes(cache_key: key)),
          metadata: hash_including(cache: cache_name)
        )
    end

    context 'with a non-ASCII key' do
      let(:key) { "🫠🤢" }

      it 'does not raise nor change the encoding' do
        allow(cache_stub).to receive(:get)
          .and_return(build(:momento_cache_client_get_response, :hit))

        expect {
          expect(
            subject
          ).to be_a(Momento::GetResponse::Hit)
        }.to not_change {
          key.encoding
        }
      end
    end

    context 'with a frozen non-ACII string' do
      let(:key) { "🫠🤢".freeze }

      it 'does not raise' do
        allow(cache_stub).to receive(:get)
          .and_return(build(:momento_cache_client_get_response, :hit))

        expect(
          subject
        ).to be_a(Momento::GetResponse::Hit)
      end
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
            subject
          ).to be_a(Momento::GetResponse::Hit).and have_attributes(
            value_string: grpc_response.cache_body
          )
        end
      end

      context 'when it is a miss' do
        let(:grpc_response) { build(:momento_cache_client_get_response, :miss) }

        it 'returns a Get::Miss' do
          expect(
            subject
          ).to be_a(Momento::GetResponse::Miss)
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
          response = subject

          expect(response.error?).to be true
          expect(response.error).to be_a_momento_error
            .with_context({ cache_name: cache_name, key: key })
            .with_grpc_exception(exception)
        end
      end

      context 'when it is a unknown exception' do
        let(:exception) { StandardError.new("the front fell off") }

        it 'raises' do
          expect {
            subject
          }.to raise_error(exception)
        end
      end
    end
  end

  describe '#set' do
    subject { client.set(cache_name, key, value) }

    let(:cache_name) { Faker::Lorem.word }
    let(:key) { Faker::Lorem.word }
    let(:value) { Faker::Lorem.paragraph }
    let(:ttl) { 1234 }

    it_behaves_like 'it validates the key'
    it_behaves_like 'it validates the value'
    it_behaves_like 'it validates the cache name'

    shared_examples 'it sends a SetRequest' do
      it 'sends a SetRequest with the cache name, key, value, and ttl' do
        allow(cache_stub).to receive(:set)
          .and_return(build(:momento_cache_client_set_response))

        set_call

        request_expectation = be_a(MomentoProtos::CacheClient::PB__SetRequest).and have_attributes(
          cache_key: key, cache_body: value, ttl_milliseconds: expected_ttl
        )

        expect(cache_stub).to have_received(:set)
          .with(
            request_expectation,
            metadata: hash_including(cache: cache_name)
          )
      end
    end

    context 'without a ttl' do
      it_behaves_like 'it sends a SetRequest' do
        subject(:set_call) { client.set(cache_name, key, value) }

        let(:expected_ttl) { client.default_ttl.milliseconds }
      end
    end

    context 'with a ttl' do
      it_behaves_like 'it sends a SetRequest' do
        subject(:set_call) { client.set(cache_name, key, value, ttl: 1_234) }

        let(:expected_ttl) { 1_234_000 }
      end
    end

    context 'with an invalid ttl' do
      let(:ttl) { "whenver" }

      it 'raises' do
        expect {
          client.set("name", "key", "value", ttl: ttl)
        }.to raise_error(ArgumentError)
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
          subject
        ).to be_a(Momento::SetResponse::Success)
      end

      context 'with a non-ASCII key and value' do
        let(:key) { "🫠🤢" }
        let(:value) { "🎉☃" }

        it 'can be set' do
          expect {
            expect(
              subject
            ).to be_a(Momento::SetResponse::Success)
          }.to not_change {
            value.encoding
          }.and not_change {
            key.encoding
          }
        end
      end

      context 'with a frozen non-ASCII key and value' do
        let(:key) { "🫠🤢".freeze }
        let(:value) { "🎉☃".freeze }

        it 'can be set' do
          expect(
            subject
          ).to be_a(Momento::SetResponse::Success)
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
          response = client.set("name", "key", "value", ttl: 123)

          expect(response.error?).to be true
          expect(response.error).to be_a_momento_error
            .with_context(
              { cache_name: "name", key: "key", value: "value", ttl: Momento::Ttl.to_ttl(123) }
            )
            .with_grpc_exception(exception)
        end
      end

      context 'when it is a unknown exception' do
        let(:exception) { StandardError.new("the front fell off") }

        it 'raises' do
          expect {
            subject
          }.to raise_error(exception)
        end
      end
    end
  end

  describe '#delete' do
    subject { client.delete(cache_name, key) }

    let(:cache_name) { Faker::Lorem.word }
    let(:key) { Faker::Lorem.word }

    it_behaves_like 'it validates the cache name'
    it_behaves_like 'it validates the key'

    it 'sends a DeleteRequest with the cache name and key' do
      allow(cache_stub).to receive(:delete)
        .and_return(build(:momento_cache_client_delete_response))

      subject

      expect(cache_stub).to have_received(:delete)
        .with(
          be_a(MomentoProtos::CacheClient::PB__DeleteRequest).and(have_attributes(cache_key: key)),
          metadata: hash_including(cache: cache_name)
        )
    end

    context 'with a non-ASCII string' do
      let(:key) { "🫠🤢" }

      it 'does not raise nor change the encoding' do
        allow(cache_stub).to receive(:delete)
          .and_return(build(:momento_cache_client_delete_response))

        expect {
          expect(
            subject
          ).to be_a(Momento::DeleteResponse::Success)
        }.to not_change {
          key.encoding
        }
      end
    end

    context 'with a frozen non-ASCII string' do
      let(:key) { "🫠🤢".freeze }

      it 'does not raise' do
        allow(cache_stub).to receive(:delete)
          .and_return(build(:momento_cache_client_delete_response))

        expect(
          subject
        ).to be_a(Momento::DeleteResponse::Success)
      end
    end

    context 'when it is a success' do
      let(:grpc_response) { build(:momento_cache_client_delete_response) }

      before do
        allow(client.send(:cache_stub)).to receive(:delete)
          .and_return(grpc_response)
      end

      it 'returns a Delete::Response' do
        expect(
          subject
        ).to be_a(Momento::DeleteResponse::Success)
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
          response = subject

          expect(response.error?).to be true
          expect(response.error).to be_a_momento_error
            .with_context({ cache_name: cache_name, key: key })
            .with_grpc_exception(exception)
        end
      end

      context 'when it is a unknown exception' do
        let(:exception) { StandardError.new("the front fell off") }

        it 'raises' do
          expect {
            subject
          }.to raise_error(exception)
        end
      end
    end
  end
end
