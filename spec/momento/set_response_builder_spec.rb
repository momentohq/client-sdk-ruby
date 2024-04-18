require 'momento/response'

RSpec.describe Momento::SetResponseBuilder do
  let(:builder) { described_class.new }

  it_behaves_like Momento::ResponseBuilder

  describe '#from_block' do
    context 'when it raises GRPC::BadStatus' do
      let(:exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::SetResponse::Error }

      it_behaves_like '#from_block wraps gRPC exceptions'
    end

    context 'when it returns a SetResponse' do
      let(:response) {
        MomentoProtos::CacheClient::PB__SetResponse.new
      }
      let(:response_class) {
        Momento::SetResponse::Success
      }

      it_behaves_like '#from_block wraps gRPC responses'

      it 'passes the key and value from context' do
        builder.context = { key: "key", value: "value" }

        momento_response = builder.from_block { response }
        expect(momento_response).to have_attributes(key: "key", value: "value")
      end
    end
  end
end
