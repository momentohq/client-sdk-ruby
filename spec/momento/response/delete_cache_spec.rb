require 'momento/response'
require 'momento/controlclient_pb'

RSpec.describe Momento::Response::DeleteCache do
  it_behaves_like '.from_block'

  describe '.from_block' do
    context 'when it is InvalidArgument' do
      let(:exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::Response::DeleteCache::Error::InvalidArgument }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it is NotFound' do
      let(:exception) { GRPC::NotFound.new }
      let(:response_class) { Momento::Response::DeleteCache::Error::NotFound }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it is PermissionDenied' do
      let(:exception) { GRPC::PermissionDenied.new }
      let(:response_class) { Momento::Response::DeleteCache::Error::PermissionDenied }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it returns a DeleteCacheResponse' do
      let(:response) {
        Momento::ControlClient::DeleteCacheResponse.new
      }
      let(:response_class) {
        Momento::Response::DeleteCache::Success
      }

      it_behaves_like 'it wraps gRPC responses'
    end
  end
end
