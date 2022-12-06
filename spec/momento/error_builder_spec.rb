RSpec.describe Momento::ErrorBuilder do
  describe '.from_exception' do
    subject { described_class.from_exception(exception, context: context) }

    let(:context) do
      { foo: 'bar' }
    end

    context 'with no context' do
      subject { described_class.from_exception(exception) }

      let(:exception) { StandardError.new("The front fell off") }

      it {
        is_expected.to be_a_momento_error
          .with_context({})
          .with_exception(exception)
      }
    end

    context 'when given an unknown error' do
      let(:exception) { StandardError.new("The front fell off") }

      it {
        is_expected.to be_a_momento_error
          .with_context(context)
          .with_exception(exception)
      }
    end

    context 'when given a GRPC error' do
      let(:exception) { GRPC::Aborted.new }

      it {
        is_expected.to be_a_momento_error
          .with_context(context)
          .with_grpc_exception(exception)
      }
    end
  end
end
