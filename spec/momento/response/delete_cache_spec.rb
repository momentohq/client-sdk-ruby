require 'momento/response'

RSpec.describe Momento::Response::DeleteCache do
  it_behaves_like 'it handles unexpected exceptions'

  describe '.build_response' do
    context 'when it is InvalidArgument' do
      let(:grpc_exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::Response::DeleteCache::InvalidArgument }

      it_behaves_like 'it wraps GRPC exceptions'
    end

    context 'when it is NotFound' do
      let(:grpc_exception) { GRPC::NotFound.new }
      let(:response_class) { Momento::Response::DeleteCache::NotFound }

      it_behaves_like 'it wraps GRPC exceptions'
    end

    context 'when it is PermissionDenied' do
      let(:grpc_exception) { GRPC::PermissionDenied.new }
      let(:response_class) { Momento::Response::DeleteCache::PermissionDenied }

      it_behaves_like 'it wraps GRPC exceptions'
    end
  end
end
