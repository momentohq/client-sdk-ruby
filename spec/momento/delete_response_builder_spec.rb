require 'momento/response'

RSpec.describe Momento::DeleteResponseBuilder do
  let(:builder) { described_class.new }

  it_behaves_like Momento::ResponseBuilder

  describe '#from_block' do
    context 'when it raises GRPC::BadStatus' do
      let(:exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::DeleteResponse::Error }

      it_behaves_like '#from_block wraps gRPC exceptions'
    end

    context 'when it returns a DeleteResponse' do
      let(:response) {
        MomentoProtos::CacheClient::PB__DeleteResponse.new
      }
      let(:response_class) {
        Momento::DeleteResponse::Success
      }

      it_behaves_like '#from_block wraps gRPC responses'
    end
  end
end
