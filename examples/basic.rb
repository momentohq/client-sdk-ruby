require 'momento'

# Get your Momento token from an environment variable.
token = ENV.fetch('MOMENTO_AUTH_TOKEN')

# Cached items will be deleted after 30 seconds.
ttl = 30_000

# Instantiate a Momento client.
client = Momento::SimpleCacheClient.new(
  auth_token: token,
  default_ttl: ttl
)

# Create a cache named "test_cache" to play with.
response = client.create_cache("test_cache")
if response.success? || response.already_exists?
  puts "Created the cache, or it already exists."
elsif response.error?
  raise "Couldn't create a cache: #{response.error}"
else
  raise
end

# Put an item in the cache.
response = client.set("test_cache", "key", "You cached something!")
if response.success?
  puts "Set an item in the cache."
elsif response.error?
  raise "Couldn't set an item in the cache: #{response.error}"
else
  raise
end

# And get it back.
response = client.get("test_cache", "key")
if response.hit?
  puts "Cache returned: #{response.value}"
elsif response.miss?
  puts "The item wasn't found in the cache."
elsif response.error?
  raise "Couldn't get an item from the cache: #{response.error}"
else
  raise
end
