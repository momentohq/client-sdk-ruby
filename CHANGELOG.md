# Changelog

## [0.4.3](https://github.com/momentohq/client-sdk-ruby/compare/momento/v0.4.2...momento/v0.4.3) (2024-04-30)


### Bug Fixes

* verbose rubygems publishing ([#156](https://github.com/momentohq/client-sdk-ruby/issues/156)) ([0f6ec1f](https://github.com/momentohq/client-sdk-ruby/commit/0f6ec1fc958bb9473b4f508f2cb2d1e35beaf90c))

## [0.4.2](https://github.com/momentohq/client-sdk-ruby/compare/momento/v0.4.1...momento/v0.4.2) (2024-04-30)


### Bug Fixes

* add git status for release-please troubleshooting ([#154](https://github.com/momentohq/client-sdk-ruby/issues/154)) ([115b4ef](https://github.com/momentohq/client-sdk-ruby/commit/115b4ef77c62344e1debd813d19adf47fa687f1b))

## [0.4.1](https://github.com/momentohq/client-sdk-ruby/compare/momento/v0.4.0...momento/v0.4.1) (2024-04-29)


### Bug Fixes

* Update release please action versions ([#152](https://github.com/momentohq/client-sdk-ruby/issues/152)) ([c4241da](https://github.com/momentohq/client-sdk-ruby/commit/c4241daa72dcb1f73eafef9ef86618e51826c3fb))

## [0.4.0](https://github.com/momentohq/client-sdk-ruby/compare/momento/v0.3.0...momento/v0.4.0) (2024-04-29)


### Features

* add a CredentialProvider ([#134](https://github.com/momentohq/client-sdk-ruby/issues/134)) ([c74f34a](https://github.com/momentohq/client-sdk-ruby/commit/c74f34a102d24b6f143376ac4c643139b2559394))
* add a value alias in sorted_set_fetch ([#149](https://github.com/momentohq/client-sdk-ruby/issues/149)) ([f310df0](https://github.com/momentohq/client-sdk-ruby/commit/f310df08735a41bd834e27ef138897c2ac5aa5ce))
* add cache config objects as CacheClient argument ([f8c1c86](https://github.com/momentohq/client-sdk-ruby/commit/f8c1c860fa05c83a766b0063835013b32cc35382))
* add cache config objects as CacheClient argument ([#142](https://github.com/momentohq/client-sdk-ruby/issues/142)) ([1158039](https://github.com/momentohq/client-sdk-ruby/commit/1158039ab4caa8fb6ab491c71c82d9eae3ad4083))
* add sorted set put and fetch by score ([#147](https://github.com/momentohq/client-sdk-ruby/issues/147)) ([a8fd259](https://github.com/momentohq/client-sdk-ruby/commit/a8fd259d09f273a3ed0c857b05610534d801673e))
* rename SimpleCacheClient to CacheClient ([37e2183](https://github.com/momentohq/client-sdk-ruby/commit/37e2183390e3184ad6ce4429df15fdd4b8b15a74))
* rename SimpleCacheClient to CacheClient ([#141](https://github.com/momentohq/client-sdk-ruby/issues/141)) ([f1e6d86](https://github.com/momentohq/client-sdk-ruby/commit/f1e6d86ea9665bb66164265a7baa85f729d798a8))
* support UTF-8 cache names instead of just ASCII ([#148](https://github.com/momentohq/client-sdk-ruby/issues/148)) ([5627f52](https://github.com/momentohq/client-sdk-ruby/commit/5627f526ccb269383289f8b3a033890f868f936d))


### Bug Fixes

* change the ruby versions in the test action to strings ([4700338](https://github.com/momentohq/client-sdk-ruby/commit/47003387cbab0739361eedcdad9662f0a0753757))
* change the ruby versions in the test action to strings ([#136](https://github.com/momentohq/client-sdk-ruby/issues/136)) ([975be89](https://github.com/momentohq/client-sdk-ruby/commit/975be891c7cea139b6365698cf80d74db718bc3f))
* fill out credential provider method docs ([#151](https://github.com/momentohq/client-sdk-ruby/issues/151)) ([90a8a39](https://github.com/momentohq/client-sdk-ruby/commit/90a8a39a50c908cc927fbdb8307fb50d29d7b960))

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
