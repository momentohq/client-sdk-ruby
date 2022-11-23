RSpec.describe Momento::Error do
  let(:error) { described_class.new(exception: exception) }
  let(:exception) { StandardError.new("the front fell off") }

  describe '#error_code' do
    it 'is not implemented' do
      expect { error.error_code }.to raise_error(NotImplementedError)
    end
  end

  describe '#message' do
    it 'is not implemented' do
      expect { error.message }.to raise_error(NotImplementedError)
    end
  end
end
