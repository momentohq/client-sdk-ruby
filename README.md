<head>
  <meta name="Momento Ruby Client Library Documentation" content="Ruby client software development kit for Momento Serverless Cache">
</head>
<img src="https://docs.momentohq.com/img/logo.svg" alt="logo" width="400"/>

[![project status](https://momentohq.github.io/standards-and-practices/badges/project-status-official.svg)](https://github.com/momentohq/standards-and-practices/blob/main/docs/momento-on-github.md)
[![project stability](https://momentohq.github.io/standards-and-practices/badges/project-stability-alpha.svg)](https://github.com/momentohq/standards-and-practices/blob/main/docs/momento-on-github.md) 

# Momento Ruby Client Library


Ruby client SDK for Momento Serverless Cache: a fast, simple, pay-as-you-go caching solution without
any of the operational overhead required by traditional caching solutions!



## Getting Started :running:

### Requirements

- A Momento API key is required, you can generate one using the [Momento Console](https://console.gomomento.com)
- Ruby 2.7 or newer.

An IDE with good Ruby support, such as [RubyMine](https://www.jetbrains.com/ruby/), is recommended.

### Examples

You can find this example code and more in [the examples directory](https://github.com/momentohq/client-sdk-ruby/tree/main/examples) of this repository.

### Installation

Install the gem and add to an application's Gemfile by executing:

```sh
bundle add momento
```

If bundler is not being used to manage dependencies, install the gem by executing:

```sh
gem install momento
```

#### Note: M1 or M2 Macs

If you're using an M1 or M2 Mac, you may have trouble installing the `grpc` gem; [see this issue for more information](https://github.com/grpc/grpc/issues/31215).

[A work around](https://github.com/grpc/grpc/pull/31151#issuecomment-1310321807) is to run `bundle config build.grpc --with-ldflags="-Wl,-undefined,dynamic_lookup"` before doing `bundle install`.

### Usage

```ruby
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

```

### Error Handling

[Momento::SimpleCacheClient](https://github.com/momentohq/client-sdk-ruby/blob/main/lib/momento/simple_cache_client.rb) follows the philosophy that when working with a service,
[exceptions are bugs](https://www.gomomento.com/blog/exceptions-are-bugs). Minor outages are a fact of life; they are normal rather than exceptional.

When there is a problem, Momento::SimpleCacheClient methods return an error response, the same as any other response. This makes errors more visible, allows your IDE to be more helpful in ensuring that you've handled the responses you care about.

Check if a response is an error with `response.error?`, get the error with `response.error`, and it can be raised as an exception with `raise response.error`. Generally, printing `response.error` tell you what you need to know, but you might want more details. Here's a contrived example.

```ruby
# This is an invalid cache name. They must be ASCII-only.
cache_name = 'çåché nåme'
response = client.create_cache(cache_name)
if response.success?
  puts "Created the cache"
elsif response.error?
  error = response.error
  puts "Creating the cache failed: #{error}"
  case error
  when Momento::Error::LimitExceededError
    puts "We'll have to slow down"
  when Momento::Error::PermissionError
    puts "We'll have to fix our auth token"
  when Momento::Error::InvalidArgumentError
    puts "We can't make a cache named #{cache_name}"
  end
end
```

Momento::SimpleCacheClient *will* raise exceptions for programmer mistakes such as passing the wrong type, typically an ArgumentError or TypeError. The exceptions are documented for each method.

See [Momento::Response](https://github.com/momentohq/client-sdk-ruby/blob/main/lib/momento/response.rb) for more about working with with error responses, and [Momento::Error](https://github.com/momentohq/client-sdk-ruby/blob/main/lib/momento/error.rb) for more about using errors.

### Tuning

Coming soon.

## Issues

Please report any bugs, issues, requests, and feedback via this repo's [issue tracker](https://github.com/momentohq/client-sdk-ruby/issues).

## Contributing

See our [instructions for CONTRIBUTING](https://github.com/momentohq/client-sdk-ruby/blob/main/CONTRIBUTING.md).

----------------------------------------------------------------------------------------
For more info, visit our website at [https://gomomento.com](https://gomomento.com)!
