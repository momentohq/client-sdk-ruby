<img src="https://docs.momentohq.com/img/logo.svg" alt="Momento logo" width="400"/>

# Momento Ruby Client Examples

## Requirements

See the [project's README](https://github.com/momentohq/client-sdk-ruby/blob/main/README.md).

## Running the examples

First, install the gem and its dependencies.

```sh
bundle
```

Then, set the required environment variables:

```bash
export MOMENTO_API_KEY=<YOUR_API_KEY>
```

And now you can run the example programs.

* `ruby ./example.rb` - shows off all the basic functionality
* `ruby ./compact.rb` - the same, written in a compact style
* `ruby ./file.rb` - demonstrates how to cache a file

If you wish to use the version of Momento in this repository, include the lib directory when you run the examples.

```sh
ruby -I../lib example.rb
```
