require 'momento/response'

RSpec.describe Momento::CreateCacheResponse do
  let(:response) { described_class.new }

  it_behaves_like Momento::Response
  it_behaves_like described_class do
    let(:types) do {} end
  end
  it_behaves_like '.from_block'

  describe '.from_block' do
    context 'when it raises an Error' do
      let(:exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::CreateCacheResponse::Error }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it raises AlreadyExists' do
      let(:exception) { GRPC::AlreadyExists.new }
      let(:response_class) { Momento::CreateCacheResponse::AlreadyExists }

      it_behaves_like 'it wraps gRPC exceptions as a response'
    end

    context 'when it returns a CreateCacheResponse' do
      let(:response) {
        Momento::ControlClient::CreateCacheResponse.new
      }
      let(:response_class) {
        Momento::CreateCacheResponse::Success
      }

      it_behaves_like 'it wraps gRPC responses'
    end
  end
end
