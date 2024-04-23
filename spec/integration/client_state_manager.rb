# Loads the cache client and cache name so they can be shared by tests
module ClientStateManager
  class << self
    def cache_client
      @cache_client ||= Momento::CacheClient.new(
        configuration: Momento::Cache::Configurations::Laptop.latest,
        credential_provider: Momento::CredentialProvider.from_env_var('MOMENTO_API_KEY'),
        default_ttl: 60 # seconds
      )
    end

    def cache_name
      @cache_name ||= ENV.fetch('TEST_CACHE_NAME', 'ruby-test-cache')
    end
  end
end
