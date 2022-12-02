require 'momento'

# Get your Momento token from an environment variable.
TOKEN = ENV.fetch('MOMENTO_AUTH_TOKEN')

# Cached items will be deleted after 12.5 seconds.
TTL = 12.5

# The name of the cache to create *and delete*
CACHE_NAME = 'test_cache'.freeze

# Instantiate a Momento client.
client = Momento::SimpleCacheClient.new(
  auth_token: TOKEN,
  default_ttl: TTL
)

# Create a cache to play with.
response = client.create_cache(CACHE_NAME)
if response.success?
  puts "Created the cache"
elsif response.already_exists?
  puts "Cache already exists."
elsif response.error?
  raise "Couldn't create a cache: #{response.error}"
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
