# Live tests against the real server.
#
# Only runs whem MOMENTO_TEST_LIVE set.
#
# Needs ALPHA_TEST_AUTH_TOKEN and TEST_CACHE_NAME.

require 'momento'

# rubocop:disable RSpec/DescribeClass
RSpec.describe 'live acceptance tests', if: ENV.fetch('MOMENTO_TEST_LIVE', nil) do
  # rubocop:enable RSpec/DescribeClass

  let(:auth_token) {
    ENV.fetch('ALPHA_TEST_AUTH_TOKEN')
  }
  let(:cache_name) {
    ENV.fetch('TEST_CACHE_NAME')
  }
  let(:client) {
    Momento::SimpleCacheClient.new(
      auth_token: auth_token,
      default_ttl: 10
    )
  }

  # Clean up after each test.
  around do |example|
    client.delete_cache(cache_name)
    example.run
    client.delete_cache(cache_name)
  end

  # rubocop:disable RSpec/ExampleLength,RSpec/MultipleExpectations
  it 'creates, lists, sets, gets, and deletes' do
    key = Faker::Lorem.word
    value = Faker::Lorem.paragraph

    expect(
      client.create_cache(cache_name)
    ).to have_attributes(
      success?: true,
      error?: false,
      error: nil
    )

    expect(client.caches).to include(cache_name)

    expect(
      client.set(cache_name, key, value)
    ).to have_attributes(
      success?: true,
      error?: false,
      error: nil
    )

    expect(
      client.get(cache_name, key)
    ).to have_attributes(
      hit?: true,
      miss?: false,
      error?: false,
      error: nil,
      value: value
    )

    expect(
      client.delete(cache_name, key)
    ).to have_attributes(
      success?: true,
      error?: false,
      error: nil
    )

    expect(
      client.get(cache_name, key)
    ).to have_attributes(
      hit?: false,
      miss?: true,
      error?: false,
      error: nil,
      value: nil
    )

    expect(
      client.delete_cache(cache_name)
    ).to have_attributes(
      success?: true,
      error?: false,
      error: nil
    )

    expect(client.caches).not_to include(cache_name)
  end
  # rubocop:enable RSpec/ExampleLength,RSpec/MultipleExpectations
end
