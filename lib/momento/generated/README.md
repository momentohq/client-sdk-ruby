# Generate proto code

1. Change into this directory, specify the path to the protos directory in the bash script, then run it:

```
cd path/to/client-sdk-ruby/lib/momento/generated/
export PROTO_PATH="path/to/client-protos/proto/"
./generate_protos.sh
```

2. Verify unit tests still pass by going back to the top-level directory and running `rspec`:

```
cd ../../..
rspec
```