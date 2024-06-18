<head>
  <meta name="Momento Ruby Client Library Documentation" content="Ruby client software development kit for Momento Cache">
</head>
<img src="https://docs.momentohq.com/img/momento-logo-forest.svg" alt="logo" width="400"/>

[![project status](https://momentohq.github.io/standards-and-practices/badges/project-status-official.svg)](https://github.com/momentohq/standards-and-practices/blob/main/docs/momento-on-github.md)
[![project stability](https://momentohq.github.io/standards-and-practices/badges/project-stability-stable.svg)](https://github.com/momentohq/standards-and-practices/blob/main/docs/momento-on-github.md)

# Momento Ruby Client Library

Momento Cache is a fast, simple, pay-as-you-go caching solution without any of the operational overhead
required by traditional caching solutions.  This repo contains the source code for the Momento Ruby client library.

To get started with Momento you will need a Momento Auth Token. You can get one from the [Momento Console](https://console.gomomento.com).

* Website: [https://www.gomomento.com/](https://www.gomomento.com/)
* Momento Documentation: [https://docs.momentohq.com/](https://docs.momentohq.com/)
* Getting Started: [https://docs.momentohq.com/getting-started](https://docs.momentohq.com/getting-started)
* Ruby SDK Documentation: [https://docs.momentohq.com/sdks/ruby](https://docs.momentohq.com/sdks/ruby)
* Discuss: [Momento Discord](https://discord.gg/3HkAKjUZGq)

# Momento Ruby SDK

To get started with Momento you will need a Momento API key. You can get one from the [Momento Console](https://console.gomomento.com/api-keys).

* Website: [https://www.gomomento.com/](https://www.gomomento.com/)
* Momento Documentation: [https://docs.momentohq.com/](https://docs.momentohq.com/)
* Getting Started: [https://docs.momentohq.com/getting-started](https://docs.momentohq.com/getting-started)
* Discuss: [Momento Discord](https://discord.gg/3HkAKjUZGq)

## Packages

The Momento Ruby SDK is available on [RubyGems](https://rubygems.org/gems/momento) 

Install the gem and add to an application's Gemfile by executing:

```sh
bundle add momento
```

If bundler is not being used to manage dependencies, install the gem by executing:

```sh
gem install momento
```

You will need Ruby 2.7 or newer.

An IDE with good Ruby support, such as [RubyMine](https://www.jetbrains.com/ruby/), is recommended.

**Note: M1 or M2 Macs**: If you're using an M1 or M2 Mac, you may have trouble installing the `grpc` gem; [see this issue for more information](https://github.com/grpc/grpc/issues/31215).

[A work around](https://github.com/grpc/grpc/pull/31151#issuecomment-1310321807) is to run `bundle config build.grpc --with-ldflags="-Wl,-undefined,dynamic_lookup"` before doing `bundle install`.

## Usage

You can find this example code and more in [the examples directory](./examples) of this repository.

```ruby
# An example of the basic functionality of
# Momento::CacheClient.

require 'momento'

# Cached items will be deleted after 12.5 seconds.
TTL_SECONDS = 12.5

# The name of the cache to create *and delete*
CACHE_NAME = ENV.fetch('MOMENTO_CACHE_NAME', 'ruby-examples')

# Create a credential provider that loads a Momento API Key from an environment variable.
credential_provider = Momento::CredentialProvider.from_env_var('MOMENTO_API_KEY')

# Instantiate a Momento client.
client = Momento::CacheClient.new(
  configuration: Momento::Cache::Configurations::Laptop.latest,
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

```

## Getting Started and Documentation

General documentation on Momento and the Momento SDKs is available on the [Momento Docs website](https://docs.momentohq.com/). Specific usage examples for the Ruby SDK are coming soon!

## Examples

Check out full working code in the [example](./example/) directory of this repository!

## Error Handling

[Momento::CacheClient](https://github.com/momentohq/client-sdk-ruby/blob/main/lib/momento/cache_client.rb) follows the philosophy that when working with a service,
[exceptions are bugs](https://www.gomomento.com/blog/exceptions-are-bugs). Minor outages are a fact of life; they are normal rather than exceptional.

When there is a problem, Momento::CacheClient methods return an error response, the same as any other response. This makes errors more visible, allows your IDE to be more helpful in ensuring that you've handled the responses you care about.

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

Momento::CacheClient *will* raise exceptions for programmer mistakes such as passing the wrong type, typically an ArgumentError or TypeError. The exceptions are documented for each method.

See [Momento::Response](https://github.com/momentohq/client-sdk-ruby/blob/main/lib/momento/response.rb) for more about working with with error responses, and [Momento::Error](https://github.com/momentohq/client-sdk-ruby/blob/main/lib/momento/error.rb) for more about using errors.

## Issues

Please report any bugs, issues, requests, and feedback via this repo's [issue tracker](https://github.com/momentohq/client-sdk-ruby/issues).

## Developing

If you are interested in contributing to the SDK, please see the [CONTRIBUTING](./CONTRIBUTING.md) docs.

----------------------------------------------------------------------------------------
For more info, visit our website at [https://gomomento.com](https://gomomento.com)!
