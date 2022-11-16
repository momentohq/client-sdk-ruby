require 'momento/response'

RSpec.describe Momento::SetResponse do
  let(:response) { described_class.new }

  it_behaves_like Momento::Response
  it_behaves_like described_class do
    let(:types) do {} end
  end
  it_behaves_like '.from_block'

  describe '.from_block' do
    context 'when it raises GRPC::BadStatus' do
      let(:exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::SetResponse::Error }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it returns a SetResponse' do
      let(:response) {
        Momento::CacheClient::SetResponse.new
      }
      let(:response_class) {
        Momento::SetResponse::Success
      }

      it_behaves_like 'it wraps gRPC responses'
    end
  end
end
