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
