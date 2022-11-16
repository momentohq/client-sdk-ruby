require 'momento/response'

RSpec.describe Momento::GetResponse do
  let(:response) { described_class.new }

  it_behaves_like Momento::Response
  it_behaves_like described_class do
    let(:types) do {} end
  end
  it_behaves_like '.from_block'

  describe '.from_block' do
    context 'when it raises GRPC::BadStatus' do
      let(:exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::GetResponse::Error }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it returns a hit' do
      it 'returns a Hit' do
        grpc_response = build(:momento_cache_client_get_response, :hit)

        expect(
          described_class.from_block { grpc_response }
        ).to be_a(Momento::GetResponse::Hit)
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
        ).to be_a(Momento::GetResponse::Miss)
      end
    end

    context 'when it returns an unknown result' do
      it 'raises' do
        grpc_response = build(:momento_cache_client_get_response, :invalid)
        expect {
          described_class.from_block { grpc_response }
        }.to raise_error("Unknown get result: Invalid")
      end
    end
  end
end
