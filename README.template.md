{{ ossHeader }}

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
{% include "./examples/example.rb" %}
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

{{ ossFooter }}
