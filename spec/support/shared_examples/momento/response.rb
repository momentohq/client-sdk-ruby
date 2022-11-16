require 'momento/response'

RSpec.shared_examples Momento::Response do
  let(:response) { described_class.new }

  describe '#error?' do
    it 'is false' do
      expect(response.error?).to be false
    end
  end
end
