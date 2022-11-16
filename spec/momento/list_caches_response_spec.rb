require 'momento/response'

RSpec.describe Momento::ListCachesResponse do
  let(:response) { described_class.new }

  it_behaves_like Momento::Response
  it_behaves_like described_class do
    let(:types) do {} end
  end
  it_behaves_like '.from_block'

  describe '.from_block' do
    context 'when a GRPC::BadStatus is raised' do
      let(:exception) { GRPC::PermissionDenied.new }
      let(:response_class) { Momento::ListCachesResponse::Error }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it returns a ListCachesResponse' do
      let(:response) {
        Momento::ControlClient::ListCachesResponse.new
      }
      let(:response_class) {
        Momento::ListCachesResponse::Caches
      }

      it_behaves_like 'it wraps gRPC responses'
    end
  end
end
