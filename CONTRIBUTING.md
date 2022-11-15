<img src="https://docs.momentohq.com/img/logo.svg" alt="logo" width="400"/>

# Welcome to client-sdk-ruby contributing guide :wave:

Thank you for taking your time to contribute to our Ruby SDK!

This guide will provide you information to start your own development and testing.

Happy coding :dancer:


## Requirements

Check out our SDK [requirements](https://github.com/momentohq/client-sdk-ruby#Requirements)!


## Installing Ruby

Ruby might already be installed on your computer, but we recommend instead using your own Ruby.

To install and manage your own Ruby, we suggest using either [`rvm`](https://rvm.io/) or [`rbenv`](https://github.com/rbenv/rbenv/).

If you're on Windows, use [RubyInstaller](https://rubyinstaller.org/).

You can also use a Docker image. `docker pull ruby` or any specific version of Ruby we support.


## Setting up the dev environment

1. Clone the repository.
2. Change to the repository directory.
3. Upgrade bundler: `gem install bundler`
4. Install the dependencies: `bundle`

This will install both the runtime and development dependencies.

## Trying it out

You can run code from the repository's `lib/` directory by adding `-Ilib` to your ruby commands. For example, `ruby -Ilib examples/basic.rb` or `irb -Ilib`. This will use the repository's code even if you have the gem installed.

You can also build a gem from local sources and install it. Run `bundle exec rake install`.

## Running unit tests

Run `rspec`. These tests will make no network calls and do not require a Momento account.

## Running integration tests

TODO

## Bug reports

Bug reports and pull requests are welcome on GitHub at https://github.com/momentohq/client-sdk-ruby.
