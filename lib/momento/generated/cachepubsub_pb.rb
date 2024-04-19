# frozen_string_literal: true

# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: cachepubsub.proto

require 'google/protobuf'

require_relative 'common_pb'
require_relative 'extensions_pb'

descriptor_data = "\n\x11\x63\x61\x63hepubsub.proto\x12\x13\x63\x61\x63he_client.pubsub\x1a\x0c\x63ommon.proto\x1a\x10\x65xtensions.proto\"k\n\x0f_PublishRequest\x12\x12\n\ncache_name\x18\x01 \x01(\t\x12\r\n\x05topic\x18\x02 \x01(\t\x12/\n\x05value\x18\x03 \x01(\x0b\x32 .cache_client.pubsub._TopicValue:\x04\x80\xb5\x18\x00\"h\n\x14_SubscriptionRequest\x12\x12\n\ncache_name\x18\x01 \x01(\t\x12\r\n\x05topic\x18\x02 \x01(\t\x12'\n\x1fresume_at_topic_sequence_number\x18\x03 \x01(\x04:\x04\x80\xb5\x18\x01\"\xc0\x01\n\x11_SubscriptionItem\x12/\n\x04item\x18\x01 \x01(\x0b\x32\x1f.cache_client.pubsub._TopicItemH\x00\x12<\n\rdiscontinuity\x18\x02 \x01(\x0b\x32#.cache_client.pubsub._DiscontinuityH\x00\x12\x34\n\theartbeat\x18\x03 \x01(\x0b\x32\x1f.cache_client.pubsub._HeartbeatH\x00\x42\x06\n\x04kind\"r\n\n_TopicItem\x12\x1d\n\x15topic_sequence_number\x18\x01 \x01(\x04\x12/\n\x05value\x18\x02 \x01(\x0b\x32 .cache_client.pubsub._TopicValue\x12\x14\n\x0cpublisher_id\x18\x03 \x01(\t\"7\n\x0b_TopicValue\x12\x0e\n\x04text\x18\x01 \x01(\tH\x00\x12\x10\n\x06\x62inary\x18\x02 \x01(\x0cH\x00\x42\x06\n\x04kind\"I\n\x0e_Discontinuity\x12\x1b\n\x13last_topic_sequence\x18\x01 \x01(\x04\x12\x1a\n\x12new_topic_sequence\x18\x02 \x01(\x04\"\x0c\n\n_Heartbeat2\xab\x01\n\x06Pubsub\x12?\n\x07Publish\x12$.cache_client.pubsub._PublishRequest\x1a\x0e.common._Empty\x12`\n\tSubscribe\x12).cache_client.pubsub._SubscriptionRequest\x1a&.cache_client.pubsub._SubscriptionItem0\x01\x42r\n\x18grpc.cache_client.pubsubP\x01Z0github.com/momentohq/client-sdk-go;client_sdk_go\xaa\x02!Momento.Protos.CacheClient.Pubsubb\x06proto3"

pool = Google::Protobuf::DescriptorPool.generated_pool

begin
  pool.add_serialized_file(descriptor_data)
rescue TypeError
  # Compatibility code: will be removed in the next major version.
  require_relative 'google/protobuf/descriptor_pb'
  parsed = Google::Protobuf::FileDescriptorProto.decode(descriptor_data)
  parsed.clear_dependency
  serialized = parsed.class.encode(parsed)
  file = pool.add_serialized_file(serialized)
  warn "Warning: Protobuf detected an import path issue while loading generated file #{__FILE__}"
  imports = []
  imports.each do |type_name, expected_filename|
    import_file = pool.lookup(type_name).file_descriptor
    if import_file.name != expected_filename
      warn "- #{file.name} imports #{expected_filename}, but that import was loaded as #{import_file.name}"
    end
  end
  warn "Each proto file must use a consistent fully-qualified name."
  warn "This will become an error in the next major version."
end

module MomentoProtos
  module CacheClient
    module Pubsub
      PB__PublishRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("cache_client.pubsub._PublishRequest").msgclass
      PB__SubscriptionRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("cache_client.pubsub._SubscriptionRequest").msgclass
      PB__SubscriptionItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("cache_client.pubsub._SubscriptionItem").msgclass
      PB__TopicItem = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("cache_client.pubsub._TopicItem").msgclass
      PB__TopicValue = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("cache_client.pubsub._TopicValue").msgclass
      PB__Discontinuity = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("cache_client.pubsub._Discontinuity").msgclass
      PB__Heartbeat = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("cache_client.pubsub._Heartbeat").msgclass
    end
  end
end