require 'momento/response'
require 'momento/controlclient_pb'

RSpec.describe Momento::Response::ListCaches do
  it_behaves_like '.from_block'

  describe '.from_block' do
    context 'when it is PermissionDenied' do
      let(:exception) { GRPC::PermissionDenied.new }
      let(:response_class) { Momento::Response::ListCaches::PermissionDenied }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it returns a ListCachesResponse' do
      let(:response) {
        Momento::ControlClient::ListCachesResponse.new
      }
      let(:response_class) {
        Momento::Response::ListCaches::Caches
      }

      it_behaves_like 'it wraps gRPC responses'
    end
  end
end
