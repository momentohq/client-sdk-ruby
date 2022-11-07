require 'momento/response'

RSpec.describe Momento::Response do
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

  describe 'status methods' do
    let(:response) { described_class.new }

    [
      :success,
      :error,
      :permission_denied,
      :already_exists,
      :invalid_argument,
      :not_found
    ].each do |status|
      describe "#{status}?" do
        method = :"#{status}?"

        it 'is false' do
          expect(response.public_send(method)).to be false
        end
      end

      describe "as_#{status}" do
        method = :"as_#{status}"

        it 'is nil' do
          expect(response.public_send(method)).to be_nil
        end
      end
    end
  end
end
