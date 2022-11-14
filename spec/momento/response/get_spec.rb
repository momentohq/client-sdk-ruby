require 'momento/response'
require 'momento/cacheclient_pb'

RSpec.describe Momento::Response::Get do
  it_behaves_like '.from_block'

  describe '.from_block' do
    context 'when it raises InvalidArgument' do
      let(:exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::Response::Get::Error::InvalidArgument }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it raises NotFound' do
      let(:exception) { GRPC::NotFound.new }
      let(:response_class) { Momento::Response::Get::Error::NotFound }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it raises PermissionDenied' do
      let(:exception) { GRPC::PermissionDenied.new }
      let(:response_class) { Momento::Response::Get::Error::PermissionDenied }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it returns a hit' do
      it 'returns a Hit' do
        grpc_response = build(:momento_cache_client_get_response, :hit)

        expect(
          described_class.from_block { grpc_response }
        ).to be_a(Momento::Response::Get::Hit)
          .and have_attributes(
            value: grpc_response.cache_body
          )
      end
    end

    context 'when it returns a Miss' do
      it 'returns a Miss' do
        grpc_response = build(:momento_cache_client_get_response, :miss)
        expect(
          described_class.from_block { grpc_response }
        ).to be_a(Momento::Response::Get::Miss)
      end
    end

    context 'when it returns an unknown result' do
      it 'raises' do
        grpc_response = build(:momento_cache_client_get_response, result: :Invalid)
        expect {
          described_class.from_block { grpc_response }
        }.to raise_error("Unknown get result: #{grpc_response.result}")
      end
    end
  end
end
