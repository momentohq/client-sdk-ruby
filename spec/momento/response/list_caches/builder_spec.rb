require 'momento'

RSpec.describe Momento::Response::ListCaches::Builder do
  it_behaves_like Momento::Response::Builder

  describe '.build_response' do
    context 'when it is PermissionDenied' do
      let(:grpc_exception) { GRPC::PermissionDenied.new }
      let(:response_class) { Momento::Response::ListCaches::PermissionDenied }

      it_behaves_like 'it wraps GRPC exceptions'
    end
  end
end
