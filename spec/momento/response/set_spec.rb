require 'momento/response'
require 'momento/cacheclient_pb'

RSpec.describe Momento::Response::Set do
  it_behaves_like '.from_block'

  describe '.from_block' do
    context 'when it is InvalidArgument' do
      let(:exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::Response::Set::Error::InvalidArgument }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it is NotFound' do
      let(:exception) { GRPC::NotFound.new }
      let(:response_class) { Momento::Response::Set::Error::NotFound }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it is PermissionDenied' do
      let(:exception) { GRPC::PermissionDenied.new }
      let(:response_class) { Momento::Response::Set::Error::PermissionDenied }

      it_behaves_like 'it wraps gRPC exceptions'
    end

    context 'when it returns a SetResponse' do
      let(:response) {
        Momento::CacheClient::SetResponse.new
      }
      let(:response_class) {
        Momento::Response::Set::Success
      }

      it_behaves_like 'it wraps gRPC responses'
    end
  end
end
