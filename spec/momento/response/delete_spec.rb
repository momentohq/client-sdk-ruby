require 'momento/response'
require 'momento/cacheclient_pb'

RSpec.describe Momento::Response::Delete do
  it_behaves_like '.from_block'

  describe '.from_block' do
    context 'when it is InvalidArgument' do
      let(:exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::Response::Delete::Error::InvalidArgument }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it is NotFound' do
      let(:exception) { GRPC::NotFound.new }
      let(:response_class) { Momento::Response::Delete::Error::NotFound }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it is PermissionDenied' do
      let(:exception) { GRPC::PermissionDenied.new }
      let(:response_class) { Momento::Response::Delete::Error::PermissionDenied }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it returns a DeleteResponse' do
      let(:response) {
        Momento::CacheClient::DeleteResponse.new
      }
      let(:response_class) {
        Momento::Response::Delete::Success
      }

      it_behaves_like 'it wraps gRPC responses'
    end
  end
end
