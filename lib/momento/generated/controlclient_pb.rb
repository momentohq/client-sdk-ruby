# frozen_string_literal: true

# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: controlclient.proto

require 'google/protobuf'

descriptor_data = "\n\x13\x63ontrolclient.proto\x12\x0e\x63ontrol_client\")\n\x13_CreateStoreRequest\x12\x12\n\nstore_name\x18\x01 \x01(\t\"\x16\n\x14_CreateStoreResponse\")\n\x13_DeleteStoreRequest\x12\x12\n\nstore_name\x18\x01 \x01(\t\"\x16\n\x14_DeleteStoreResponse\"(\n\x12_ListStoresRequest\x12\x12\n\nnext_token\x18\x01 \x01(\t\"P\n\x13_ListStoresResponse\x12%\n\x05store\x18\x01 \x03(\x0b\x32\x16.control_client._Store\x12\x12\n\nnext_token\x18\x02 \x01(\t\"\x1c\n\x06_Store\x12\x12\n\nstore_name\x18\x01 \x01(\t\"\xda\x02\n\x11_SimilarityMetric\x12V\n\x14\x65uclidean_similarity\x18\x01 \x01(\x0b\x32\x36.control_client._SimilarityMetric._EuclideanSimilarityH\x00\x12H\n\rinner_product\x18\x02 \x01(\x0b\x32/.control_client._SimilarityMetric._InnerProductH\x00\x12P\n\x11\x63osine_similarity\x18\x03 \x01(\x0b\x32\x33.control_client._SimilarityMetric._CosineSimilarityH\x00\x1a\x16\n\x14_EuclideanSimilarity\x1a\x0f\n\r_InnerProduct\x1a\x13\n\x11_CosineSimilarityB\x13\n\x11similarity_metric\"\x7f\n\x13_CreateIndexRequest\x12\x12\n\nindex_name\x18\x01 \x01(\t\x12\x16\n\x0enum_dimensions\x18\x02 \x01(\x04\x12<\n\x11similarity_metric\x18\x03 \x01(\x0b\x32!.control_client._SimilarityMetric\"\x16\n\x14_CreateIndexResponse\")\n\x13_DeleteIndexRequest\x12\x12\n\nindex_name\x18\x01 \x01(\t\"\x16\n\x14_DeleteIndexResponse\"\x15\n\x13_ListIndexesRequest\"\xc8\x01\n\x14_ListIndexesResponse\x12<\n\x07indexes\x18\x01 \x03(\x0b\x32+.control_client._ListIndexesResponse._Index\x1ar\n\x06_Index\x12\x12\n\nindex_name\x18\x01 \x01(\t\x12\x16\n\x0enum_dimensions\x18\x02 \x01(\x04\x12<\n\x11similarity_metric\x18\x03 \x01(\x0b\x32!.control_client._SimilarityMetric\")\n\x13_DeleteCacheRequest\x12\x12\n\ncache_name\x18\x01 \x01(\t\"\x16\n\x14_DeleteCacheResponse\")\n\x13_CreateCacheRequest\x12\x12\n\ncache_name\x18\x01 \x01(\t\"\x16\n\x14_CreateCacheResponse\"(\n\x12_ListCachesRequest\x12\x12\n\nnext_token\x18\x01 \x01(\t\"x\n\x0c_CacheLimits\x12\x18\n\x10max_traffic_rate\x18\x01 \x01(\r\x12\x1b\n\x13max_throughput_kbps\x18\x02 \x01(\r\x12\x18\n\x10max_item_size_kb\x18\x03 \x01(\r\x12\x17\n\x0fmax_ttl_seconds\x18\x04 \x01(\x04\"m\n\x0c_TopicLimits\x12\x18\n\x10max_publish_rate\x18\x01 \x01(\r\x12\x1e\n\x16max_subscription_count\x18\x02 \x01(\r\x12#\n\x1bmax_publish_message_size_kb\x18\x03 \x01(\r\"\x84\x01\n\x06_Cache\x12\x12\n\ncache_name\x18\x01 \x01(\t\x12\x32\n\x0c\x63\x61\x63he_limits\x18\x02 \x01(\x0b\x32\x1c.control_client._CacheLimits\x12\x32\n\x0ctopic_limits\x18\x03 \x01(\x0b\x32\x1c.control_client._TopicLimits\"P\n\x13_ListCachesResponse\x12%\n\x05\x63\x61\x63he\x18\x01 \x03(\x0b\x32\x16.control_client._Cache\x12\x12\n\nnext_token\x18\x02 \x01(\t\"/\n\x18_CreateSigningKeyRequest\x12\x13\n\x0bttl_minutes\x18\x01 \x01(\r\"<\n\x19_CreateSigningKeyResponse\x12\x0b\n\x03key\x18\x01 \x01(\t\x12\x12\n\nexpires_at\x18\x02 \x01(\x04\"*\n\x18_RevokeSigningKeyRequest\x12\x0e\n\x06key_id\x18\x01 \x01(\t\"\x1b\n\x19_RevokeSigningKeyResponse\"1\n\x0b_SigningKey\x12\x0e\n\x06key_id\x18\x01 \x01(\t\x12\x12\n\nexpires_at\x18\x02 \x01(\x04\"-\n\x17_ListSigningKeysRequest\x12\x12\n\nnext_token\x18\x01 \x01(\t\"`\n\x18_ListSigningKeysResponse\x12\x30\n\x0bsigning_key\x18\x01 \x03(\x0b\x32\x1b.control_client._SigningKey\x12\x12\n\nnext_token\x18\x02 \x01(\t\"(\n\x12_FlushCacheRequest\x12\x12\n\ncache_name\x18\x01 \x01(\t\"\x15\n\x13_FlushCacheResponse2\xd9\t\n\nScsControl\x12Z\n\x0b\x43reateCache\x12#.control_client._CreateCacheRequest\x1a$.control_client._CreateCacheResponse\"\x00\x12Z\n\x0b\x44\x65leteCache\x12#.control_client._DeleteCacheRequest\x1a$.control_client._DeleteCacheResponse\"\x00\x12W\n\nListCaches\x12\".control_client._ListCachesRequest\x1a#.control_client._ListCachesResponse\"\x00\x12W\n\nFlushCache\x12\".control_client._FlushCacheRequest\x1a#.control_client._FlushCacheResponse\"\x00\x12i\n\x10\x43reateSigningKey\x12(.control_client._CreateSigningKeyRequest\x1a).control_client._CreateSigningKeyResponse\"\x00\x12i\n\x10RevokeSigningKey\x12(.control_client._RevokeSigningKeyRequest\x1a).control_client._RevokeSigningKeyResponse\"\x00\x12\x66\n\x0fListSigningKeys\x12'.control_client._ListSigningKeysRequest\x1a(.control_client._ListSigningKeysResponse\"\x00\x12Z\n\x0b\x43reateIndex\x12#.control_client._CreateIndexRequest\x1a$.control_client._CreateIndexResponse\"\x00\x12Z\n\x0b\x44\x65leteIndex\x12#.control_client._DeleteIndexRequest\x1a$.control_client._DeleteIndexResponse\"\x00\x12Z\n\x0bListIndexes\x12#.control_client._ListIndexesRequest\x1a$.control_client._ListIndexesResponse\"\x00\x12Z\n\x0b\x43reateStore\x12#.control_client._CreateStoreRequest\x1a$.control_client._CreateStoreResponse\"\x00\x12Z\n\x0b\x44\x65leteStore\x12#.control_client._DeleteStoreRequest\x1a$.control_client._DeleteStoreResponse\"\x00\x12W\n\nListStores\x12\".control_client._ListStoresRequest\x1a#.control_client._ListStoresResponse\"\x00\x42h\n\x13grpc.control_clientP\x01Z0github.com/momentohq/client-sdk-go;client_sdk_go\xaa\x02\x1cMomento.Protos.ControlClientb\x06proto3"

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
  module ControlClient
    PB__CreateStoreRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._CreateStoreRequest").msgclass
    PB__CreateStoreResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._CreateStoreResponse").msgclass
    PB__DeleteStoreRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._DeleteStoreRequest").msgclass
    PB__DeleteStoreResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._DeleteStoreResponse").msgclass
    PB__ListStoresRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._ListStoresRequest").msgclass
    PB__ListStoresResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._ListStoresResponse").msgclass
    PB__Store = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._Store").msgclass
    PB__SimilarityMetric = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._SimilarityMetric").msgclass
    PB__SimilarityMetric::PB__EuclideanSimilarity = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._SimilarityMetric._EuclideanSimilarity").msgclass
    PB__SimilarityMetric::PB__InnerProduct = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._SimilarityMetric._InnerProduct").msgclass
    PB__SimilarityMetric::PB__CosineSimilarity = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._SimilarityMetric._CosineSimilarity").msgclass
    PB__CreateIndexRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._CreateIndexRequest").msgclass
    PB__CreateIndexResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._CreateIndexResponse").msgclass
    PB__DeleteIndexRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._DeleteIndexRequest").msgclass
    PB__DeleteIndexResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._DeleteIndexResponse").msgclass
    PB__ListIndexesRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._ListIndexesRequest").msgclass
    PB__ListIndexesResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._ListIndexesResponse").msgclass
    PB__ListIndexesResponse::PB__Index = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._ListIndexesResponse._Index").msgclass
    PB__DeleteCacheRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._DeleteCacheRequest").msgclass
    PB__DeleteCacheResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._DeleteCacheResponse").msgclass
    PB__CreateCacheRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._CreateCacheRequest").msgclass
    PB__CreateCacheResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._CreateCacheResponse").msgclass
    PB__ListCachesRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._ListCachesRequest").msgclass
    PB__CacheLimits = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._CacheLimits").msgclass
    PB__TopicLimits = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._TopicLimits").msgclass
    PB__Cache = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._Cache").msgclass
    PB__ListCachesResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._ListCachesResponse").msgclass
    PB__CreateSigningKeyRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._CreateSigningKeyRequest").msgclass
    PB__CreateSigningKeyResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._CreateSigningKeyResponse").msgclass
    PB__RevokeSigningKeyRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._RevokeSigningKeyRequest").msgclass
    PB__RevokeSigningKeyResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._RevokeSigningKeyResponse").msgclass
    PB__SigningKey = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._SigningKey").msgclass
    PB__ListSigningKeysRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._ListSigningKeysRequest").msgclass
    PB__ListSigningKeysResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._ListSigningKeysResponse").msgclass
    PB__FlushCacheRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._FlushCacheRequest").msgclass
    PB__FlushCacheResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._FlushCacheResponse").msgclass
  end
end
