require 'momento/response'

RSpec.describe Momento::Response::DeleteCache do
  describe '.build_response' do
    shared_examples 'it wraps GRPC exceptions' do
      it 'returns the approriate response' do
        expect(
          described_class.build_response(grpc_exception)
        ).to be_a response_class
      end

      it 'wraps the exception' do
        expect(
          described_class.build_response(grpc_exception).grpc_exception
        ).to eq grpc_exception
      end
    end

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

    context 'when the exception is unexpected' do
      let(:grpc_exception) { instance_double(StandardError) }

      it 'raises' do
        expect {
          described_class.build_response(grpc_exception)
        }.to raise_error(/Unknown GRPC exception/)
      end
    end
  end
end
