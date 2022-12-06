RSpec.describe Momento::ResponseBuilder do
  let(:builder) { described_class.new }

  describe '#from_block' do
    it 'is not implemented' do
      expect {
        builder.from_block
      }.to raise_error(NotImplementedError)
    end
  end
end
