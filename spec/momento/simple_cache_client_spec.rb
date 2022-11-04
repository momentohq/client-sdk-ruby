RSpec.describe Momento::SimpleCacheClient do
  let(:control_endpoint) { Faker::Internet.domain_name }
  let(:cache_endpoint) { Faker::Internet.domain_name }
  let(:token) {
    build(:auth_token, c: cache_endpoint, cp: control_endpoint)
  }
  let(:client) {
    described_class.new(auth_token: token)
  }

  it 'parses the auth_token' do
    expect(client).to have_attributes(
      control_endpoint: control_endpoint,
      cache_endpoint: cache_endpoint
    )
  end
end
