require 'momento'

RSpec.describe Momento::CreateCacheResponseBuilder do
  let(:builder) { described_class.new }

  it_behaves_like Momento::ResponseBuilder

  describe '#from_block' do
    context 'when it raises an Error' do
      let(:exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::CreateCacheResponse::Error }

      it_behaves_like '#from_block wraps gRPC exceptions'
    end

    context 'when it raises AlreadyExists' do
      let(:exception) { GRPC::AlreadyExists.new }
      let(:response_class) { Momento::CreateCacheResponse::AlreadyExists }

      it_behaves_like '#from_block wraps gRPC exceptions as a response'
    end

    context 'when it returns a CreateCacheResponse' do
      let(:response) {
        MomentoProtos::ControlClient::PB__CreateCacheResponse.new
      }
      let(:response_class) {
        Momento::CreateCacheResponse::Success
      }

      it_behaves_like '#from_block wraps gRPC responses'
    end
  end
end
