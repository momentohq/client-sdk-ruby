# An example of the basic functionality of
# Momento::CacheClient.

require 'momento'

# Cached items will be deleted after 12.5 seconds.
TTL_SECONDS = 12.5

# The name of the cache to create *and delete*
CACHE_NAME = ENV.fetch('MOMENTO_CACHE_NAME', 'ruby-examples')

# Create a credential provider that loads a Momento API Key from an environment variable.
credential_provider = Momento::CredentialProvider.from_env_var('MOMENTO_API_KEY')

# This is a reasonable configuration for dev work on a laptop.
configuration = Momento::Cache::Configurations::Laptop.latest
# This configuration might be better for a production where you want more aggressive timeouts
# configuration = Momento::Cache::Configuration::InRegion.latest
# To set a custom timeout, you can use the with_timeout method.
# configuration = configuration.with_timeout(10_000)
# To increase the number of TCP connections for a client where you expect a high volume of traffic,
# you can use the with_num_connections method.
# configuration = configuration.with_num_connections(4)

# Instantiate a Momento client.
client = Momento::CacheClient.new(
  configuration: configuration,
  credential_provider: credential_provider,
  default_ttl: TTL_SECONDS
)

# Create a cache to play with.
response = client.create_cache(CACHE_NAME)
if response.success?
  puts "Created the cache."
elsif response.already_exists?
  puts "Cache already exists."
elsif response.error?
  raise "Couldn't create a cache: #{response.error}"
end

# List our caches.
response = client.list_caches
if response.success?
  puts "Caches: #{response.cache_names&.join(", ")}"
elsif response.error?
  raise "Couldn't list the caches: #{response.error}"
end

# Put an item in the cache.
response = client.set(CACHE_NAME, "key", "You cached something!")
if response.success?
  puts "Set an item in the cache."
elsif response.error?
  raise "Couldn't set an item in the cache: #{response.error}"
end

# And get it back.
response = client.get(CACHE_NAME, "key")
if response.hit?
  puts "Cache returned: #{response.value_string}"
elsif response.miss?
  puts "The item wasn't found in the cache."
elsif response.error?
  raise "Couldn't get an item from the cache: #{response.error}"
end

# Now delete it.
response = client.delete(CACHE_NAME, "key")
if response.success?
  puts "Key/value deleted."
elsif response.error?
  raise "Couldn't delete an item from the cache: #{response.error}"
end

# And delete our test cache.
response = client.delete_cache(CACHE_NAME)
if response.success?
  puts "Deleted the cache."
elsif response.error?
  raise "Couldn't create a cache: #{response.error}"
end
