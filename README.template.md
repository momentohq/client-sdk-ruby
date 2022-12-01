{{ ossHeader }}

## Getting Started :running:

### Requirements

- A Momento Auth Token is required, you can generate one using
  the [Momento CLI](https://github.com/momentohq/momento-cli).
- Ruby 2.7 or newer.

An IDE with good Ruby support, such as [RubyMine](https://www.jetbrains.com/ruby/), is recommended.

### Installation

Install the gem and add to an application's Gemfile by executing:

```sh
$ bundle add momento
```

If bundler is not being used to manage dependencies, install the gem by executing:

```sh
$ gem install momento
```

#### Note: M1 or M2 Macs

If you're using an M1 or M2 Mac, you may have trouble installing the `grpc` gem; [see this issue for more information](https://github.com/grpc/grpc/issues/31215).

[A work around](https://github.com/grpc/grpc/pull/31151#issuecomment-1310321807) is to run `bundle config build.grpc --with-ldflags="-Wl,-undefined,dynamic_lookup"` before doing `bundle install`.

### Usage

```ruby
{{ usageExampleCode }}
```

You can find this example code and more in [the examples directory](https://github.com/momentohq/client-sdk-ruby/tree/main/examples) of this repository.

## Issues

Please report any bugs, issues, requests, and feedback via this repo's [issue tracker](https://github.com/momentohq/client-sdk-ruby/issues).

## Contributing

See our [instructions for CONTRIBUTING](https://github.com/momentohq/client-sdk-ruby/blob/main/CONTRIBUTING.md).

{{ ossFooter }}
