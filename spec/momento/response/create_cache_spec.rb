require 'momento/response'

RSpec.describe Momento::Response::CreateCache do
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
