# Momento

Client for Momento serverless caching service.

## Installation

Install the gem and add to an application's Gemfile by executing:

    $ bundle add momento

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install momento

### M1 or M2 Macs

If you're using an M1 or M2 Mac, [you may have trouble installing the `grpc` gem](https://github.com/grpc/grpc/issues/31215).

[A work around](https://github.com/grpc/grpc/pull/31151#issuecomment-1310321807) is to run `bundle config build.grpc --with-ldflags="-Wl,-undefined,dynamic_lookup"` before doing `bundle install`.

## Requirements

* A Momento Auth Token is required, you can generate one using the Momento CLI
* Ruby >= 2.7

## Usage

```
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
```

You can run this code from [examples/basic.rb](examples/basic.rb).

## Contributing

See our [instructions for CONTRIBUTING](./CONTRIBUTING.md).
