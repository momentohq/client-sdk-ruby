# Momento

Client for [Momento serverless caching service](https://www.gomomento.com/).

## Installation

Install the gem and add to an application's Gemfile by executing:

```sh
$ bundle add momento
```

If bundler is not being used to manage dependencies, install the gem by executing:

```sh
$ gem install momento
```

### M1 or M2 Macs

If you're using an M1 or M2 Mac, you may have trouble installing the `grpc` gem; [see this issue for more information](https://github.com/grpc/grpc/issues/31215).

[A work around](https://github.com/grpc/grpc/pull/31151#issuecomment-1310321807) is to run `bundle config build.grpc --with-ldflags="-Wl,-undefined,dynamic_lookup"` before doing `bundle install`.

## Requirements

* A Momento Auth Token is required, you can generate one using the Momento CLI
* Ruby >= 2.7

## Usage

```ruby
require 'momento'

# Get your Momento token from an environment variable.
token = ENV.fetch('MOMENTO_AUTH_TOKEN')

# Cached items will be deleted after 12.5 seconds.
ttl = 12.5

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
  puts "Cache returned: #{response.value_string}"
elsif response.miss?
  puts "The item wasn't found in the cache."
elsif response.error?
  raise "Couldn't get an item from the cache: #{response.error}"
else
  raise
end
```

You can find this code in [the examples directory](https://github.com/momentohq/client-sdk-ruby/tree/main/examples).

## Contributing

See our [instructions for CONTRIBUTING](https://github.com/momentohq/client-sdk-ruby/blob/main/CONTRIBUTING.md).
