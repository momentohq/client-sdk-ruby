require 'momento'

# Get your Momento token from an environment variable.
token = ENV.fetch('MOMENTO_TOKEN')

# Cached items will be deleted after 30 seconds.
ttl = 30_000

# Instantiate a Momento client.
client = Momento::SimpleCacheClient.new(
  auth_token: token,
  default_ttl: ttl
)

# Create a cache named "test_cache" to play with.
case response = client.create_cache("test_cache")
when Momento::Response::CreateCache::Error::AlreadyExists
  # ignore if it already exists
when Momento::Response::Error
  raise "Couldn't create a cache: #{response}"
end

# Put an item in the cache.
case response = client.set("test_cache", "key", "You cached something!")
when Momento::Response::Error
  raise "Couldn't set an item in the cache: #{response}"
end

# And get it back.
case response = client.get("test_cache", "key")
when Momento::Response::Get::Hit
  puts "Cache returned: #{response}"
when Momento::Response::Get::Miss
  puts "The item wasn't found in the cache."
when Momento::Response::Error
  raise "Couldn't get an item from the cache: #{response}"
end
