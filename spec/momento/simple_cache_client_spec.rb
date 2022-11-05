RSpec.describe Momento::SimpleCacheClient do
  let(:control_endpoint) { Faker::Internet.domain_name }
  let(:cache_endpoint) { Faker::Internet.domain_name }
  let(:token) {
    build(:auth_token, c: cache_endpoint, cp: control_endpoint)
  }

  describe '#new' do
    it 'can be created' do
      expect(
        described_class.new(auth_token: token)
      ).to be_a described_class
    end
  end
end
