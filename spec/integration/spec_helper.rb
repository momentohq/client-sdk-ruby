require 'rspec'
require 'momento'
require_relative 'test_utils'
require_relative 'client_state_manager'
require_relative 'shared_examples'

RSpec.configure do |config|
  config.include ClientStateManager
  config.include SharedExamples

  config.before(:suite) do
    cache_client = ClientStateManager.cache_client
    cache_name = ClientStateManager.cache_name

    response = cache_client.create_cache(cache_name)
    raise "Couldn't create test cache: #{response.error}" if response.error?
  end

  config.after(:suite) do
    cache_client = ClientStateManager.cache_client
    cache_name = ClientStateManager.cache_name

    response = cache_client.delete_cache(cache_name)
    raise "Couldn't delete test cache: #{response.error}" if response.error?
  end
end
