require 'momento/response'

RSpec.describe Momento::ListCachesResponseBuilder do
  let(:builder) { described_class.new }

  it_behaves_like Momento::ResponseBuilder

  describe '#from_block' do
    context 'when it raises GRPC::BadStatus' do
      let(:exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::ListCachesResponse::Error }

      it_behaves_like '#from_block wraps gRPC exceptions'
    end

    context 'when it returns a ListCachesResponse' do
      let(:response) {
        Momento::ControlClient::ListCachesResponse.new
      }
      let(:response_class) {
        Momento::ListCachesResponse::Success
      }

      it_behaves_like '#from_block wraps gRPC responses'
    end
  end
end
