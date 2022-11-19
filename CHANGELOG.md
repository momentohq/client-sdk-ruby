# Changelog

## 0.1.0 (2022-11-19)


### Features

* A working cache client! ([6e4ca15](https://github.com/momentohq/client-sdk-ruby/commit/6e4ca152388e23e416b456ffacc63cdf83244928))
* Add a CacheClient stub. ([61eb8ea](https://github.com/momentohq/client-sdk-ruby/commit/61eb8ea617bacdf2d9056f986b032f7a07aa1ba7))
* Add a default TTL to the SimpleCacheClient ([108c0ef](https://github.com/momentohq/client-sdk-ruby/commit/108c0ef335f149d4e6c7951a7b33e2e268643d5c))
* Add an agent header. ([a4271c6](https://github.com/momentohq/client-sdk-ruby/commit/a4271c659bcd9116d8ef4d800bbdc54eade64c20))
* Add bundler and rubocop as dependencies. ([46674d4](https://github.com/momentohq/client-sdk-ruby/commit/46674d4a6cd14dab0a27e491e48063e4ecd9b2ca))
* Add get, set, and delete. ([573b179](https://github.com/momentohq/client-sdk-ruby/commit/573b179177481a4298c5af947d056aab44a70c71))
* Add the Apache 2.0 license. ([3347f3d](https://github.com/momentohq/client-sdk-ruby/commit/3347f3db4934846d5f1ea40a696ab328686fbd13))
* Basic cache create and delete. ([7ffa875](https://github.com/momentohq/client-sdk-ruby/commit/7ffa8758ced869905af8ca07a4a9823efcc86aab))
* Basic GRPC exception/response wrappers. ([d825d7c](https://github.com/momentohq/client-sdk-ruby/commit/d825d7c744a3a1d5124b413e129debff2289a04d))
* Change ListCachesResponse::Caches to ::Success ([27c9dc8](https://github.com/momentohq/client-sdk-ruby/commit/27c9dc89ecd2665f2b8dc3dc1abaadfc27c1993a))
* Completely reorganize the responses. ([18a2556](https://github.com/momentohq/client-sdk-ruby/commit/18a25566591420477e25c0712af8f1a2a07260f5))
* Fill in gem skeleton. ([8dc2a73](https://github.com/momentohq/client-sdk-ruby/commit/8dc2a73ceaec86f90a40f3283ae8bf32855b74db))
* Generate gem skeleton with Bundler. ([5375822](https://github.com/momentohq/client-sdk-ruby/commit/53758221bca68ddece6f2105f6fcbc923c84ab75))
* Generate protocol buffer classes. ([bb0595c](https://github.com/momentohq/client-sdk-ruby/commit/bb0595cb365598918334337640a327a3539421ef))
* Ignore IDE poop. ([d6cee63](https://github.com/momentohq/client-sdk-ruby/commit/d6cee633b6b7c527dfa3e7e4cb8bd4b4a23b8a1c))
* Momento::Response::ListCaches ([d72e9af](https://github.com/momentohq/client-sdk-ruby/commit/d72e9afc856d2a3a2f9e43222930d5aa39f04f02))
* Momento::SimpleCacheClient parses the JWT ([1770f7a](https://github.com/momentohq/client-sdk-ruby/commit/1770f7a2a6afdbcd53c892f2f0b96d78fc3e025e))
* Momento::SimpleCacheClient#caches ([90595bf](https://github.com/momentohq/client-sdk-ruby/commit/90595bf4f1a1a926907b42f66153b3353ff17ddc))
* Momento::SimpleControlClient#list_caches ([4bc8d37](https://github.com/momentohq/client-sdk-ruby/commit/4bc8d37c49f92bee63eb3fcc72adc42c59bb1b3e))
* Move all ListCaches errors under Error. ([9a1aeb9](https://github.com/momentohq/client-sdk-ruby/commit/9a1aeb95b9dbda9f7565a67c47f9a41a9e77754a))
* Move Delete errors under the Error hierarchy. ([a6cc2b1](https://github.com/momentohq/client-sdk-ruby/commit/a6cc2b1bc0971a90c45b1865da3156617d924fe5))
* Move DeleteCache errors into their own Error hierarchy. ([626622d](https://github.com/momentohq/client-sdk-ruby/commit/626622df01ca3532f8aa3892d7dd76c1c18cfae8))
* Move Get errors under their own hierarchy. ([473f04a](https://github.com/momentohq/client-sdk-ruby/commit/473f04aa82b8e71ee8f075b70fd2b7150d227bf9))
* Move the generated protobuf modules under Momento module. ([aed327d](https://github.com/momentohq/client-sdk-ruby/commit/aed327defc97b1e0295055e69cc5449d04a6b862))
* Put all Set errors under its own Error hiearchy. ([bca637a](https://github.com/momentohq/client-sdk-ruby/commit/bca637a1c090cc2ce3f9f95c968a5fde0883d226))
* Put CreateCache errors into their own hierarchy. ([71bb04a](https://github.com/momentohq/client-sdk-ruby/commit/71bb04a5d68dedd0c0353b6d8bf9d779dd1c18d0))
* Remove the as_responsetype and responsetype? methods. ([00cf276](https://github.com/momentohq/client-sdk-ruby/commit/00cf2762fc469a2aa75984577940487a2a850f90))
* Rename the gem to momento. ([c55e40a](https://github.com/momentohq/client-sdk-ruby/commit/c55e40aca64cf1bdfbc1d122ca653a4c0c4188b7))
* Use the Github Ruby starter workflow. ([7874fbd](https://github.com/momentohq/client-sdk-ruby/commit/7874fbd66b010b4a86ade18bced664693c7dc594))


### Bug Fixes

* Add basic version requirements to our dependencies. ([7494fc4](https://github.com/momentohq/client-sdk-ruby/commit/7494fc4530053ad55d1fe8845c7aa23504e6d908))
* Fix the generated protobuf classes. ([3614f3e](https://github.com/momentohq/client-sdk-ruby/commit/3614f3e027f102aa3ac7ab2650cedb88d62cdf5f))
* Fix the homepage to point at the gem's, not Momento's. ([ee9af97](https://github.com/momentohq/client-sdk-ruby/commit/ee9af97278b0633ec0063bba964b677c800acbf5))
* Handle non-8bit ASCII. ([515b2db](https://github.com/momentohq/client-sdk-ruby/commit/515b2dbb895aa22617fc55112bde45b1e745708c))
* Handle non-ASCII cache keys ([cb6d6c6](https://github.com/momentohq/client-sdk-ruby/commit/cb6d6c69ef93f43ea1e348fc36b27e9216bc4b43))
* Handle setting frozen strings. ([7869506](https://github.com/momentohq/client-sdk-ruby/commit/7869506206f03b54773f0cb282ab996f18b78cb2))
* Test Momento::Response and fix the resulting problems. ([efdb3f8](https://github.com/momentohq/client-sdk-ruby/commit/efdb3f8abb2354617ec31f38737efa03716808e4))


### Miscellaneous Chores

* release 0.1.0 ([836c3ab](https://github.com/momentohq/client-sdk-ruby/commit/836c3abd5745760b7fd47624afba4123572be082))
