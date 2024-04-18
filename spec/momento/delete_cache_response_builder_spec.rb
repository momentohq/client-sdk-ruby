require 'momento/response'

RSpec.describe Momento::DeleteCacheResponseBuilder do
  let(:builder) { described_class.new }

  it_behaves_like Momento::ResponseBuilder

  describe '#from_block' do
    context 'when it raises an Error' do
      let(:exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::DeleteCacheResponse::Error }

      it_behaves_like '#from_block wraps gRPC exceptions'
    end

    context 'when it returns a DeleteCacheResponse' do
      let(:response) {
        MomentoProtos::ControlClient::PB__DeleteCacheResponse.new
      }
      let(:response_class) {
        Momento::DeleteCacheResponse::Success
      }

      it_behaves_like '#from_block wraps gRPC responses'
    end
  end
end
