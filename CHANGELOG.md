# Changelog

## [0.3.0](https://github.com/momentohq/client-sdk-ruby/compare/momento-v0.2.0...momento/v0.3.0) (2023-11-09)


### Features

* add support for v1 tokens ([0a98c34](https://github.com/momentohq/client-sdk-ruby/commit/0a98c3404972966a7c4c2017908f2c204532712d))

## [0.2.0](https://github.com/momentohq/client-sdk-ruby/compare/momento-v0.1.0...momento/v0.2.0) (2022-12-07)

### Breaking Changes

* TTLs are now in seconds.
* `response.value` was split into `response.value_bytes` and `response.value_string`
* Stringifying a Momento::GetResponse no longer gives you the value.
* `response.exception` is now `response.error.cause`

### Features

* Momento::Responses now stringfy with useful information.
* `response.error` is a real Exception and can be raised
* `response.error` is now a Momento::Error with expanded error information.
* nil and non-String keys, values, and cache names are now TypeErrors.
* Non-ASCII cache names are now InvalidArgument responses.
* An invalid TTL will raise ArgumentError.
* All response methods are discoverable in an IDE.
* Improve the README
* Complete YARD class and method documentation
* More examples, and instructions how to run them.
* Document how error handling works.

## 0.1.0 (2022-11-21)

First release.
