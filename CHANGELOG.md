# Changelog

## [0.6.0](https://github.com/momentohq/client-sdk-ruby/compare/momento/v0.5.2...momento/v0.6.0) (2025-12-15)


### Features

* new credential provider methods for accepting global api keys ([eb4737f](https://github.com/momentohq/client-sdk-ruby/commit/eb4737ff608e15dad77064e40157da3b4691b2da))
* new credential provider methods for accepting v2 api keys ([#195](https://github.com/momentohq/client-sdk-ruby/issues/195)) ([79e3777](https://github.com/momentohq/client-sdk-ruby/commit/79e37776ef9c7a8703bddc3dfbe569af8e42e888))


### Bug Fixes

* disable dynamic DNS service config ([#194](https://github.com/momentohq/client-sdk-ruby/issues/194)) ([d9a0976](https://github.com/momentohq/client-sdk-ruby/commit/d9a0976dec3c8ab68e8ed4a83d50ee97963fb4b1))
* only configure git in release please if the repo was checked out ([#192](https://github.com/momentohq/client-sdk-ruby/issues/192)) ([d202329](https://github.com/momentohq/client-sdk-ruby/commit/d2023298b388e36616e766157d2a7ad017f07917))

## [0.5.2](https://github.com/momentohq/client-sdk-ruby/compare/momento/v0.5.1...momento/v0.5.2) (2024-11-25)


### Bug Fixes

* copyright info ([87d44d5](https://github.com/momentohq/client-sdk-ruby/commit/87d44d525041c4cd2e060fd63765ebb35904badb))
* copyright info ([#190](https://github.com/momentohq/client-sdk-ruby/issues/190)) ([47f3904](https://github.com/momentohq/client-sdk-ruby/commit/47f3904d39451957313f3306323e2c636945d971))

## [0.5.1](https://github.com/momentohq/client-sdk-ruby/compare/momento/v0.5.0...momento/v0.5.1) (2024-06-18)


### Bug Fixes

* headers must be lower case ([#181](https://github.com/momentohq/client-sdk-ruby/issues/181)) ([6067002](https://github.com/momentohq/client-sdk-ruby/commit/606700265113c06c36ea6c603418c606101ddbb6))

## [0.5.0](https://github.com/momentohq/client-sdk-ruby/compare/momento/v0.4.9...momento/v0.5.0) (2024-06-18)


### Features

* add InRegion pre-built config ([#180](https://github.com/momentohq/client-sdk-ruby/issues/180)) ([6dd2ef4](https://github.com/momentohq/client-sdk-ruby/commit/6dd2ef47443dbbd0cae28e1d4451c74352310aa3))
* add runtime version header, only send agent headers on first request ([#177](https://github.com/momentohq/client-sdk-ruby/issues/177)) ([2292a35](https://github.com/momentohq/client-sdk-ruby/commit/2292a3575c551a2a36c9c3f1a31f0c6870e1c4d1))
* add support for multiple grpc channels, fix configuration modifiers ([#176](https://github.com/momentohq/client-sdk-ruby/issues/176)) ([5753247](https://github.com/momentohq/client-sdk-ruby/commit/57532472d418db54c6eadd046ea6cbf0a53e4e96))


### Bug Fixes

* add Gemfile.lock to .gitignore ([45e0b6c](https://github.com/momentohq/client-sdk-ruby/commit/45e0b6cdfb19a337f6cb6c17afe2f21fd86b1eb5))
* improve error handling for env var cred provider, other fixes ([#173](https://github.com/momentohq/client-sdk-ruby/issues/173)) ([c0b691b](https://github.com/momentohq/client-sdk-ruby/commit/c0b691b8c925d99b6a95a9cecee160b777b9dfab))

## [0.4.9](https://github.com/momentohq/client-sdk-ruby/compare/momento/v0.4.8...momento/v0.4.9) (2024-04-30)

### Bug Fixes

* remove token and specify email for the redundant tag ([#168](https://github.com/momentohq/client-sdk-ruby/issues/168)) ([c119376](https://github.com/momentohq/client-sdk-ruby/commit/c11937641acce6b55dbb7e59f87f548769ad9313))

## [0.4.8](https://github.com/momentohq/client-sdk-ruby/compare/momento/v0.4.7...momento/v0.4.8) (2024-04-30)


### Bug Fixes

* check out the repo with the machine user token ([#166](https://github.com/momentohq/client-sdk-ruby/issues/166)) ([67845af](https://github.com/momentohq/client-sdk-ruby/commit/67845af1da172271ea0e604d4ab8d6e749a7d7c1))

## [0.4.7](https://github.com/momentohq/client-sdk-ruby/compare/momento/v0.4.6...momento/v0.4.7) (2024-04-30)


### Bug Fixes

* update the grpc dependency ([#164](https://github.com/momentohq/client-sdk-ruby/issues/164)) ([00c0ee5](https://github.com/momentohq/client-sdk-ruby/commit/00c0ee578c63b2003b6de23506715447d762997a))

## [0.4.6](https://github.com/momentohq/client-sdk-ruby/compare/momento/v0.4.5...momento/v0.4.6) (2024-04-30)


### Bug Fixes

* check for local changes on release please failure ([#162](https://github.com/momentohq/client-sdk-ruby/issues/162)) ([bf8322c](https://github.com/momentohq/client-sdk-ruby/commit/bf8322c2cbd887c595db537838e227a0e66ebeb3))

## [0.4.5](https://github.com/momentohq/client-sdk-ruby/compare/momento/v0.4.4...momento/v0.4.5) (2024-04-30)


### Bug Fixes

* check for local changes after publishing the gem ([#160](https://github.com/momentohq/client-sdk-ruby/issues/160)) ([cd9f242](https://github.com/momentohq/client-sdk-ruby/commit/cd9f242d224b6541d11fe06df23311d7ee6f19d0))

## [0.4.4](https://github.com/momentohq/client-sdk-ruby/compare/momento/v0.4.3...momento/v0.4.4) (2024-04-30)


### Bug Fixes

* separate 'bundle install' to see if it modifies the checkout ([#158](https://github.com/momentohq/client-sdk-ruby/issues/158)) ([dbb5d20](https://github.com/momentohq/client-sdk-ruby/commit/dbb5d20619fb556eeebec7f80ff55e02bd14c282))

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
