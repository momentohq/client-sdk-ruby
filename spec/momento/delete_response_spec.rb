require 'momento/response'

RSpec.describe Momento::DeleteResponse do
  let(:response) { described_class.new }

  it_behaves_like Momento::Response
  it_behaves_like described_class do
    let(:types) do {} end
  end
  it_behaves_like '.from_block'

  describe '.from_block' do
    context 'when it raises a GRPC::BadStatus' do
      let(:exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::DeleteResponse::Error }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it returns a DeleteResponse' do
      let(:response) {
        Momento::CacheClient::DeleteResponse.new
      }
      let(:response_class) {
        Momento::DeleteResponse::Success
      }

      it_behaves_like 'it wraps gRPC responses'
    end
  end
end
