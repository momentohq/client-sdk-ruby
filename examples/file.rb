# This is an example of storing binary data.
#
# It will cache a test image, read it back,
# and write it to disk as test_copy.jpg.

require 'momento'

# Cached items will be deleted after 12.5 seconds.
TTL_SECONDS = 12.5

# The name of the cache to create *and delete*
CACHE_NAME = ENV.fetch('MOMENTO_CACHE_NAME')

# So it can be run from the top of the repo
# or from the examples directory.
FILE_LOCATIONS = [
  "spec/support/assets/test.jpg",
  "../spec/support/assets/test.jpg"
].freeze

# Create a credential provider that loads a Momento API Key from an environment variable.
credential_provider = Momento::CredentialProvider.from_env_var('MOMENTO_API_KEY')

# Instantiate a Momento client.
client = Momento::SimpleCacheClient.new(
  credential_provider: credential_provider,
  default_ttl: TTL_SECONDS
)

# Create a cache for testing, or use an already existing one.
response = client.create_cache(CACHE_NAME)
raise response.error if response.error?

# Read an image file.
file = FILE_LOCATIONS.find { |f| File.exist?(f) }
contents = File.read(file)

# Add the image to the cache.
puts "Caching #{file}"
client.set(CACHE_NAME, "test.jpg", contents)
raise response.error if response.error?

puts "Retrieving the image"
response = client.get(CACHE_NAME, "test.jpg")
raise "Cache image was not found!" if response.miss?
raise response.error if response.error?

puts "Writing the image as test_copy.jpg"
f = File.open("test_copy.jpg", "wb")
f.write(response.value_bytes)
f.close

# Delete our test cache.
response = client.delete_cache(CACHE_NAME)
raise response.error if response.error?

puts "Now open test_copy.jpg"
