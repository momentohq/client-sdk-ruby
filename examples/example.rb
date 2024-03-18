# An example of the basic functionality of
# Momento::SimpleCacheClient.

require 'momento'

# Get your Momento token from an environment variable.
TOKEN = ENV.fetch('MOMENTO_API_KEY')

# Cached items will be deleted after 12.5 seconds.
TTL_SECONDS = 12.5

# The name of the cache to create *and delete*
CACHE_NAME = ENV.fetch('MOMENTO_CACHE_NAME')

# Instantiate a Momento client.
client = Momento::SimpleCacheClient.new(
  auth_token: TOKEN,
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
puts "Caches: #{client.caches.to_a.join(", ")}"

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
