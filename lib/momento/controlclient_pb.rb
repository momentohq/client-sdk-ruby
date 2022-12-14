# @private

# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: controlclient.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("controlclient.proto", :syntax => :proto3) do
    add_message "control_client._DeleteCacheRequest" do
      optional :cache_name, :string, 1
    end
    add_message "control_client._DeleteCacheResponse" do
    end
    add_message "control_client._CreateCacheRequest" do
      optional :cache_name, :string, 1
    end
    add_message "control_client._CreateCacheResponse" do
    end
    add_message "control_client._ListCachesRequest" do
      optional :next_token, :string, 1
    end
    add_message "control_client._Cache" do
      optional :cache_name, :string, 1
    end
    add_message "control_client._ListCachesResponse" do
      repeated :cache, :message, 1, "control_client._Cache"
      optional :next_token, :string, 2
    end
    add_message "control_client._CreateSigningKeyRequest" do
      optional :ttl_minutes, :uint32, 1
    end
    add_message "control_client._CreateSigningKeyResponse" do
      optional :key, :string, 1
      optional :expires_at, :uint64, 2
    end
    add_message "control_client._RevokeSigningKeyRequest" do
      optional :key_id, :string, 1
    end
    add_message "control_client._RevokeSigningKeyResponse" do
    end
    add_message "control_client._SigningKey" do
      optional :key_id, :string, 1
      optional :expires_at, :uint64, 2
    end
    add_message "control_client._ListSigningKeysRequest" do
      optional :next_token, :string, 1
    end
    add_message "control_client._ListSigningKeysResponse" do
      repeated :signing_key, :message, 1, "control_client._SigningKey"
      optional :next_token, :string, 2
    end
  end
end

module Momento
  module ControlClient
    DeleteCacheRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._DeleteCacheRequest").msgclass
    DeleteCacheResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._DeleteCacheResponse").msgclass
    CreateCacheRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._CreateCacheRequest").msgclass
    CreateCacheResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._CreateCacheResponse").msgclass
    ListCachesRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._ListCachesRequest").msgclass
    Cache = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._Cache").msgclass
    ListCachesResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._ListCachesResponse").msgclass
    CreateSigningKeyRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._CreateSigningKeyRequest").msgclass
    CreateSigningKeyResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._CreateSigningKeyResponse").msgclass
    RevokeSigningKeyRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._RevokeSigningKeyRequest").msgclass
    RevokeSigningKeyResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._RevokeSigningKeyResponse").msgclass
    SigningKey = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._SigningKey").msgclass
    ListSigningKeysRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._ListSigningKeysRequest").msgclass
    ListSigningKeysResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("control_client._ListSigningKeysResponse").msgclass
  end
end
