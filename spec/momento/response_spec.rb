require 'momento/response'

RSpec.describe Momento::Response do
  it_behaves_like described_class do
    let(:response) { build(:momento_response) }
  end

  describe '.wrap_grpc_exception' do
    shared_examples 'it wraps GRPC exceptions' do
      it 'returns the approriate response' do
        expect(
          described_class.wrap_grpc_exception(grpc_exception)
        ).to be_a response_class
      end

      it 'wraps the exception' do
        expect(
          described_class.wrap_grpc_exception(grpc_exception).grpc_exception
        ).to eq grpc_exception
      end
    end

    context 'when it is AlreadyExists' do
      let(:grpc_exception) { GRPC::AlreadyExists.new }
      let(:response_class) { Momento::Response::AlreadyExists }

      it_behaves_like 'it wraps GRPC exceptions'
    end

    context 'when it is InvalidArgument' do
      let(:grpc_exception) { GRPC::InvalidArgument.new }
      let(:response_class) { Momento::Response::InvalidArgument }

      it_behaves_like 'it wraps GRPC exceptions'
    end

    context 'when it is NotFound' do
      let(:grpc_exception) { GRPC::NotFound.new }
      let(:response_class) { Momento::Response::NotFound }

      it_behaves_like 'it wraps GRPC exceptions'
    end

    context 'when it is PermissionDenied' do
      let(:grpc_exception) { GRPC::PermissionDenied.new }
      let(:response_class) { Momento::Response::PermissionDenied }

      it_behaves_like 'it wraps GRPC exceptions'
    end

    context 'when the exception is unexpected' do
      let(:grpc_exception) { instance_double(StandardError) }

      it 'raises' do
        expect {
          described_class.wrap_grpc_exception(grpc_exception)
        }.to raise_error(/Unknown GRPC exception/)
      end
    end
  end
end
