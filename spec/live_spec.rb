# Live tests against the real server.
#
# Only runs whem MOMENTO_TEST_LIVE set.
#
# Needs TEST_AUTH_TOKEN and TEST_CACHE_NAME.

require 'momento'

# rubocop:disable RSpec/DescribeClass
RSpec.describe 'live acceptance tests', if: ENV.fetch('MOMENTO_TEST_LIVE', nil) do
  # rubocop:enable RSpec/DescribeClass

  let(:auth_token) {
    ENV.fetch('TEST_AUTH_TOKEN')
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

  shared_context 'when the cache already exists', :include_cache_exists do
    before {
      client.create_cache(cache_name)
    }
  end

  shared_context 'when the cache does not exist', :include_cache_does_not_exist do
    # We don't have to do anything, the cache is deleted before each example.
  end

  shared_context 'when the cache name is empty', :include_empty_cache_name do
    let(:cache_name) { "" }
  end

  shared_context 'when the cache name is invalid', :include_invalid_cache_name do
    let(:cache_name) { "süpé® çåçhê 9ººº" }
  end

  shared_context 'when the server cannot be contacted', :include_invalid_server do
    let(:auth_token) {
      build(:auth_token,
        c: "thesystemis.down",
        cp: "thesystemis.down"
      )
    }
  end

  shared_examples 'it handles invalid cache names' do
    it "responds with InvalidArgumentError", :include_empty_cache_name do
      is_expected.to have_attributes(
        error?: true,
        error: have_attributes(
          error_code: :INVALID_ARGUMENT_ERROR
        )
      )
    end

    it "responds with InvalidArgumentError", :include_invalid_cache_name do
      is_expected.to have_attributes(
        error?: true,
        error: have_attributes(
          error_code: :INVALID_ARGUMENT_ERROR
        )
      )
    end
  end

  shared_examples 'it handles server failures' do
    it "responds with SERVER_UNAVAILABLE", :include_invalid_server do
      is_expected.to have_attributes(
        error?: true,
        error: have_attributes(
          error_code: :SERVER_UNAVAILABLE
        )
      )
    end
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

  describe '#create_cache' do
    subject {
      client.create_cache(cache_name)
    }

    it "responds with already exists", :include_cache_exists do
      is_expected.to have_attributes(
        success?: false,
        error?: false,
        already_exists?: true,
        error: nil
      )
    end

    it_behaves_like 'it handles server failures'
    it_behaves_like 'it handles invalid cache names'
  end

  describe '#delete_cache' do
    subject {
      client.delete_cache(cache_name)
    }

    it "responds with not found", :include_cache_does_not_exist do
      is_expected.to have_attributes(
        success?: false,
        error?: true,
        error: have_attributes(
          error_code: :NOT_FOUND_ERROR
        )
      )
    end

    it_behaves_like 'it handles server failures'
    skip "Invalid cache name handling is inconsistent" do
      it_behaves_like 'it handles invalid cache names'
    end
  end
end
