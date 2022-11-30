RSpec.shared_examples Momento::Response::Error do
  describe '#to_s' do
    it 'contains the error message' do
      expect(response.to_s).to include(response.error.message)
    end
  end
end
