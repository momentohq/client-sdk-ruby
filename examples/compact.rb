# This does the same work as in example.rb, but demonstrates a more compact style.

require 'momento'

# Cached items will be deleted after 12.5 seconds.
TTL_SECONDS = 12.5

# The name of the cache to create *and delete*
CACHE_NAME = ENV.fetch('MOMENTO_CACHE_NAME')

# Create a credential provider that loads a Momento API Key from an environment variable.
credential_provider = Momento::CredentialProvider.from_env_var('MOMENTO_API_KEY')

# Instantiate a Momento client.
client = Momento::CacheClient.new(
  credential_provider: credential_provider,
  default_ttl: TTL_SECONDS
)

# Create a cache to play with.
# It might be created, or it might already exist.
response = client.create_cache(CACHE_NAME)
raise response.error if response.error?

# List our caches.
puts "Caches: #{client.caches.to_a.join(", ")}"

# Put an item in the cache.
response = client.set(CACHE_NAME, "key", "You cached something!")
raise response.error if response.error?

# And get it back.
response = client.get(CACHE_NAME, "key")
puts response.value_string || "The item wasn't found in the cache."
raise response.error if response.error?

# Now delete it.
response = client.delete(CACHE_NAME, "key")
raise response.error if response.error?

# And delete our test cache.
response = client.delete_cache(CACHE_NAME)
raise response.error if response.error?
