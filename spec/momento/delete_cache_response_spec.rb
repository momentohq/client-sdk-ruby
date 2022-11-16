require 'momento/response'

RSpec.describe Momento::DeleteCacheResponse do
  let(:response) { described_class.new }

  it_behaves_like Momento::Response
  it_behaves_like described_class do
    let(:types) do {} end
  end
  it_behaves_like '.from_block'

  describe '.from_block' do
    context 'when it raises an Error' do
      let(:exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::DeleteCacheResponse::Error }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it returns a DeleteCacheResponse' do
      let(:response) {
        Momento::ControlClient::DeleteCacheResponse.new
      }
      let(:response_class) {
        Momento::DeleteCacheResponse::Success
      }

      it_behaves_like 'it wraps gRPC responses'
    end
  end
end
