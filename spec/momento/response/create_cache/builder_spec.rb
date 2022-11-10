require 'momento/response'

RSpec.describe Momento::Response::CreateCache::Builder do
  it_behaves_like Momento::Response::Builder

  describe '.build_response' do
    context 'when it is AlreadyExists' do
      let(:grpc_exception) { GRPC::AlreadyExists.new }
      let(:response_class) { Momento::Response::CreateCache::AlreadyExists }

      it_behaves_like 'it wraps GRPC exceptions'
    end

    context 'when it is InvalidArgument' do
      let(:grpc_exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::Response::CreateCache::InvalidArgument }

      it_behaves_like 'it wraps GRPC exceptions'
    end

    context 'when it is PermissionDenied' do
      let(:grpc_exception) { GRPC::PermissionDenied.new }
      let(:response_class) { Momento::Response::CreateCache::PermissionDenied }

      it_behaves_like 'it wraps GRPC exceptions'
    end
  end
end
