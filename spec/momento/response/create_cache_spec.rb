require 'momento/response'
require 'momento/controlclient_pb'

RSpec.describe Momento::Response::CreateCache do
  it_behaves_like '.from_block'

  describe '.from_block' do
    context 'when it raises AlreadyExists' do
      let(:exception) { GRPC::AlreadyExists.new }
      let(:response_class) { Momento::Response::CreateCache::AlreadyExists }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it raises InvalidArgument' do
      let(:exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::Response::CreateCache::InvalidArgument }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it raises PermissionDenied' do
      let(:exception) { GRPC::PermissionDenied.new }
      let(:response_class) { Momento::Response::CreateCache::PermissionDenied }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it returns a CreateCacheResponse' do
      let(:response) {
        Momento::ControlClient::CreateCacheResponse.new
      }
      let(:response_class) {
        Momento::Response::CreateCache::Success
      }

      it_behaves_like 'it wraps gRPC responses'
    end
  end
end
