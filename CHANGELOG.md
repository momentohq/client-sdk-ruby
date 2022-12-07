# Changelog

## [0.2.0](https://github.com/momentohq/client-sdk-ruby/compare/momento-v0.1.0...momento/v0.2.0) (2022-12-07)


### Features

* A working cache client! ([6e4ca15](https://github.com/momentohq/client-sdk-ruby/commit/6e4ca152388e23e416b456ffacc63cdf83244928))
* Add a CacheClient stub. ([61eb8ea](https://github.com/momentohq/client-sdk-ruby/commit/61eb8ea617bacdf2d9056f986b032f7a07aa1ba7))
* Add a default TTL to the SimpleCacheClient ([108c0ef](https://github.com/momentohq/client-sdk-ruby/commit/108c0ef335f149d4e6c7951a7b33e2e268643d5c))
* Add an agent header. ([a4271c6](https://github.com/momentohq/client-sdk-ruby/commit/a4271c659bcd9116d8ef4d800bbdc54eade64c20))
* Add bundler and rubocop as dependencies. ([46674d4](https://github.com/momentohq/client-sdk-ruby/commit/46674d4a6cd14dab0a27e491e48063e4ecd9b2ca))
* Add dependenabot version updates for the example directory. ([fd63e38](https://github.com/momentohq/client-sdk-ruby/commit/fd63e38ca9618042d9170175bf80452ba6e75eec))
* Add get, set, and delete. ([573b179](https://github.com/momentohq/client-sdk-ruby/commit/573b179177481a4298c5af947d056aab44a70c71))
* Add Momento::Error and use it. ([a3dbc54](https://github.com/momentohq/client-sdk-ruby/commit/a3dbc548add82fcc0f85285a44a523b15b41207e))
* Add Momento::Response#error ([f2503cc](https://github.com/momentohq/client-sdk-ruby/commit/f2503ccb804d6104502f112a1725028e32f46eb3))
* Add the Apache 2.0 license. ([3347f3d](https://github.com/momentohq/client-sdk-ruby/commit/3347f3db4934846d5f1ea40a696ab328686fbd13))
* Add TransportDetails and GrpcDetails for transport specific errors ([7d29d21](https://github.com/momentohq/client-sdk-ruby/commit/7d29d21b199c2de66839bf6d4547333e894b53d6))
* All classes stringify starting with the class name. ([42cb0a9](https://github.com/momentohq/client-sdk-ruby/commit/42cb0a907bbce3042b7091b88fa73cc7be5913bf))
* All error responses show their message. ([5af96d4](https://github.com/momentohq/client-sdk-ruby/commit/5af96d417dd6e1041dd6c676dd707f539d3a2f32))
* Basic cache create and delete. ([7ffa875](https://github.com/momentohq/client-sdk-ruby/commit/7ffa8758ced869905af8ca07a4a9823efcc86aab))
* Basic GRPC exception/response wrappers. ([d825d7c](https://github.com/momentohq/client-sdk-ruby/commit/d825d7c744a3a1d5124b413e129debff2289a04d))
* Change error_codes to Symbols. ([8a61197](https://github.com/momentohq/client-sdk-ruby/commit/8a61197600bee8b8f0663f41a8f33520c4f81363))
* Change ListCachesResponse::Caches to ::Success ([27c9dc8](https://github.com/momentohq/client-sdk-ruby/commit/27c9dc89ecd2665f2b8dc3dc1abaadfc27c1993a))
* Completely reorganize the responses. ([18a2556](https://github.com/momentohq/client-sdk-ruby/commit/18a25566591420477e25c0712af8f1a2a07260f5))
* Display the key and value which is being set. ([e49b690](https://github.com/momentohq/client-sdk-ruby/commit/e49b690f8f974e52d07734f8878dac7180cc94d3))
* Fill in gem skeleton. ([8dc2a73](https://github.com/momentohq/client-sdk-ruby/commit/8dc2a73ceaec86f90a40f3283ae8bf32855b74db))
* Generate gem skeleton with Bundler. ([5375822](https://github.com/momentohq/client-sdk-ruby/commit/53758221bca68ddece6f2105f6fcbc923c84ab75))
* Generate protocol buffer classes. ([bb0595c](https://github.com/momentohq/client-sdk-ruby/commit/bb0595cb365598918334337640a327a3539421ef))
* Handle invalid keys, values, and cache names. ([#81](https://github.com/momentohq/client-sdk-ruby/issues/81)) ([d41c36b](https://github.com/momentohq/client-sdk-ruby/commit/d41c36b99ec6af86bf17a54e3f0cda9170e0c9c3)), closes [#34](https://github.com/momentohq/client-sdk-ruby/issues/34)
* Ignore IDE poop. ([d6cee63](https://github.com/momentohq/client-sdk-ruby/commit/d6cee633b6b7c527dfa3e7e4cb8bd4b4a23b8a1c))
* Make #value discoverable ([#68](https://github.com/momentohq/client-sdk-ruby/issues/68)) ([51a4ee4](https://github.com/momentohq/client-sdk-ruby/commit/51a4ee4a4cf4a5356c183363d7ea779a2e4cb75d)), closes [#44](https://github.com/momentohq/client-sdk-ruby/issues/44)
* Make #value discoverable. ([c4e090d](https://github.com/momentohq/client-sdk-ruby/commit/c4e090db23d49624878006ddac3f2c6e14026e29))
* Make ListCachesResponse methods discoverable. ([0e8d5a6](https://github.com/momentohq/client-sdk-ruby/commit/0e8d5a615471aee3a5290c300109d0e933ad083d))
* Momento::Response::ListCaches ([d72e9af](https://github.com/momentohq/client-sdk-ruby/commit/d72e9afc856d2a3a2f9e43222930d5aa39f04f02))
* Momento::SimpleCacheClient parses the JWT ([1770f7a](https://github.com/momentohq/client-sdk-ruby/commit/1770f7a2a6afdbcd53c892f2f0b96d78fc3e025e))
* Momento::SimpleCacheClient#caches ([90595bf](https://github.com/momentohq/client-sdk-ruby/commit/90595bf4f1a1a926907b42f66153b3353ff17ddc))
* Momento::SimpleControlClient#list_caches ([4bc8d37](https://github.com/momentohq/client-sdk-ruby/commit/4bc8d37c49f92bee63eb3fcc72adc42c59bb1b3e))
* Move all ListCaches errors under Error. ([9a1aeb9](https://github.com/momentohq/client-sdk-ruby/commit/9a1aeb95b9dbda9f7565a67c47f9a41a9e77754a))
* Move Delete errors under the Error hierarchy. ([a6cc2b1](https://github.com/momentohq/client-sdk-ruby/commit/a6cc2b1bc0971a90c45b1865da3156617d924fe5))
* Move DeleteCache errors into their own Error hierarchy. ([626622d](https://github.com/momentohq/client-sdk-ruby/commit/626622df01ca3532f8aa3892d7dd76c1c18cfae8))
* Move Get errors under their own hierarchy. ([473f04a](https://github.com/momentohq/client-sdk-ruby/commit/473f04aa82b8e71ee8f075b70fd2b7150d227bf9))
* Move the generated protobuf modules under Momento module. ([aed327d](https://github.com/momentohq/client-sdk-ruby/commit/aed327defc97b1e0295055e69cc5449d04a6b862))
* Only display a few of the listed caches. ([f5cac2c](https://github.com/momentohq/client-sdk-ruby/commit/f5cac2cda6f91bb6a0c6dc1cbf8e8ea743e9bbde))
* Pass call context through to the Error response. ([b5ae63c](https://github.com/momentohq/client-sdk-ruby/commit/b5ae63c01555636cd404d72262cbe1d04a437ce7))
* Put all Set errors under its own Error hiearchy. ([bca637a](https://github.com/momentohq/client-sdk-ruby/commit/bca637a1c090cc2ce3f9f95c968a5fde0883d226))
* Put CreateCache errors into their own hierarchy. ([71bb04a](https://github.com/momentohq/client-sdk-ruby/commit/71bb04a5d68dedd0c0353b6d8bf9d779dd1c18d0))
* Raise an ArgumentError if the auth token is invalid. ([dd8ae91](https://github.com/momentohq/client-sdk-ruby/commit/dd8ae91e104ead63bbeae2ebeeb0d4502c3812fc)), closes [#34](https://github.com/momentohq/client-sdk-ruby/issues/34)
* Raise TypeError when the key or value is not a String. ([eb13be5](https://github.com/momentohq/client-sdk-ruby/commit/eb13be5fe614e59cd0976ab79742213e207cff28)), closes [#66](https://github.com/momentohq/client-sdk-ruby/issues/66)
* Remove the as_responsetype and responsetype? methods. ([00cf276](https://github.com/momentohq/client-sdk-ruby/commit/00cf2762fc469a2aa75984577940487a2a850f90))
* Rename the gem to momento. ([c55e40a](https://github.com/momentohq/client-sdk-ruby/commit/c55e40aca64cf1bdfbc1d122ca653a4c0c4188b7))
* response.error is a real Exception. ([a77d43c](https://github.com/momentohq/client-sdk-ruby/commit/a77d43ca7fb05971da818217409d12e6fa11caa7)), closes [#85](https://github.com/momentohq/client-sdk-ruby/issues/85)
* response.error is a real Exception. ([#86](https://github.com/momentohq/client-sdk-ruby/issues/86)) ([b56efdc](https://github.com/momentohq/client-sdk-ruby/commit/b56efdc018c3597b2eb80fd80b258da2e75d0454)), closes [#85](https://github.com/momentohq/client-sdk-ruby/issues/85)
* Turn non-ASCII cache names into Invalid Argument error responses. ([d16680e](https://github.com/momentohq/client-sdk-ruby/commit/d16680e1bf854f4dd7b2d72f37547cecb350d8f9)), closes [#41](https://github.com/momentohq/client-sdk-ruby/issues/41)
* Use the Github Ruby starter workflow. ([7874fbd](https://github.com/momentohq/client-sdk-ruby/commit/7874fbd66b010b4a86ade18bced664693c7dc594))
* Use the Standards & Practices error codes. ([c5d7690](https://github.com/momentohq/client-sdk-ruby/commit/c5d7690f7107cd50496684f09f8e07c30456b8f7))
* Validate cache names are the right type. ([7393178](https://github.com/momentohq/client-sdk-ruby/commit/739317819767bd080d12c1cc85dc3d6803b59acb)), closes [#37](https://github.com/momentohq/client-sdk-ruby/issues/37)
* Validate the ttl. ([ab51845](https://github.com/momentohq/client-sdk-ruby/commit/ab518453c06bb90cd34c74d2cef1d4b00e657bb8))


### Bug Fixes

* Add basic version requirements to our dependencies. ([7494fc4](https://github.com/momentohq/client-sdk-ruby/commit/7494fc4530053ad55d1fe8845c7aa23504e6d908))
* Error on invalid TTLs. ([#78](https://github.com/momentohq/client-sdk-ruby/issues/78)) ([088bb64](https://github.com/momentohq/client-sdk-ruby/commit/088bb644f5be0a2300801d5e3f4d59bc704053d4)), closes [#35](https://github.com/momentohq/client-sdk-ruby/issues/35)
* Fix the generated protobuf classes. ([3614f3e](https://github.com/momentohq/client-sdk-ruby/commit/3614f3e027f102aa3ac7ab2650cedb88d62cdf5f))
* Fix the homepage to point at the gem's, not Momento's. ([ee9af97](https://github.com/momentohq/client-sdk-ruby/commit/ee9af97278b0633ec0063bba964b677c800acbf5))
* Handle non-8bit ASCII. ([515b2db](https://github.com/momentohq/client-sdk-ruby/commit/515b2dbb895aa22617fc55112bde45b1e745708c))
* Handle non-ASCII cache keys ([cb6d6c6](https://github.com/momentohq/client-sdk-ruby/commit/cb6d6c69ef93f43ea1e348fc36b27e9216bc4b43))
* Handle setting frozen strings. ([7869506](https://github.com/momentohq/client-sdk-ruby/commit/7869506206f03b54773f0cb282ab996f18b78cb2))
* Referring to a method that does not exist. ([cd7da0c](https://github.com/momentohq/client-sdk-ruby/commit/cd7da0cda5ec08f06930c30d8f925ef5fb820d70))
* Referring to a method that does not exist. ([#84](https://github.com/momentohq/client-sdk-ruby/issues/84)) ([0dfa9cb](https://github.com/momentohq/client-sdk-ruby/commit/0dfa9cb06549bcf2717117c34f68ff7d86d2fc22))
* Test Momento::Response and fix the resulting problems. ([efdb3f8](https://github.com/momentohq/client-sdk-ruby/commit/efdb3f8abb2354617ec31f38737efa03716808e4))


### Miscellaneous Chores

* release 0.1.0 ([836c3ab](https://github.com/momentohq/client-sdk-ruby/commit/836c3abd5745760b7fd47624afba4123572be082))
* release v0.2.0 ([63ebfb3](https://github.com/momentohq/client-sdk-ruby/commit/63ebfb3e209859476f1dbc836f214a42cadf0f7e))

v0.2.0
Tue Dec  6 18:46:35 UTC 2022

* BREAKING CHANGE: TTLs are now in seconds.
* BREAKING CHANGE: `response.value` was split into `response.value_bytes` and `response.value_string`
* BREAKING CHANGE: Stringifying a Momento::GetResponse no longer gives you the value.
* BREAKING CHANGE: `response.exception` is now `response.error.cause`
* feature: Momento::Responses now stringfy with useful information.
* feature: `response.error` is a real Exception and can be raised
* feature: `response.error` is now a Momento::Error with expanded error information.
* feature: nil and non-String keys, values, and cache names are now TypeErrors.
* feature: Non-ASCII cache names are now InvalidArgument repsonses.
* feature: An invalid TTL will raise ArgumentError.
* feature: All response methods are discoverable in an IDE.
* docs: Improve the README
* docs: Complete YARD class and method documentation
* docs: More examples, and instructions how to run them.
* docs: Document how error handling works.
