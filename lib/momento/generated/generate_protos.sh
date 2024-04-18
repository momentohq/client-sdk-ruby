#!/bin/bash
set -e
set -x

# Must specify the path to the proto files
if [ -z "${PROTO_PATH}" ]; then
  echo "PROTO_PATH is not set, please specify the path to the client-protos/proto directory"
  exit 1
fi

# Remove existing generated code
rm -f *_pb.rb

# Copy files over temporarily
cp ${PROTO_PATH}/*.proto ./

# Remove files we don't want to generate code from
rm -f ./httpcache.proto
rm -f ./vectorindex.proto

# Generate the code
grpc_tools_ruby_protoc -I ./ --ruby_out=./ --grpc_out=./ ./*.proto

# Remove the protos
rm -f ./*.proto

# In the *_pb.rb files, replace the require with require_relative
sed -i '' -E "s/require '(.*)_pb'/require_relative '\1_pb'/g" *_pb.rb

# Wrap the generated code in a module named MomentoProtos but only if not "module Scs"
for file in *_pb.rb; do
  sed -i '' -E 's/^module (.*)/module MomentoProtos::\1/g' $file
done

# Run the linter, converts from :: syntax to nested modules
rubocop -A --disable-uncorrectable *_pb.rb 

# In the *_services_pb.rb files, change the module names.
# * rename ::ControlClient to ::MomentoProtos::ControlClient
# * rename ::CacheClient to ::MomentoProtos::CacheClient
for file in *_services_pb.rb; do
  sed -i '' -E 's/::ControlClient::/::MomentoProtos::ControlClient::/g' $file
  sed -i '' -E 's/::CacheClient::/::MomentoProtos::CacheClient::/g' $file
done

# Run the linter
rubocop -A *_pb.rb
