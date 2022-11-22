require 'momento/response'

RSpec.describe Momento::GetResponse do
  let(:response) { described_class.new }

  it_behaves_like Momento::Response
  it_behaves_like described_class do
    let(:types) do {} end
  end

  describe '#value' do
    it 'is nil' do
      expect(response.value).to be_nil
    end
  end
end
