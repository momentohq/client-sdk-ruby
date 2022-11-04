# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: controlclient.proto for package 'control_client'

require 'grpc'
require 'controlclient_pb'

module ControlClient
  module ScsControl
    class Service

      include ::GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'control_client.ScsControl'

      rpc :CreateCache, ::ControlClient::CreateCacheRequest, ::ControlClient::CreateCacheResponse
      rpc :DeleteCache, ::ControlClient::DeleteCacheRequest, ::ControlClient::DeleteCacheResponse
      rpc :ListCaches, ::ControlClient::ListCachesRequest, ::ControlClient::ListCachesResponse
      rpc :CreateSigningKey, ::ControlClient::CreateSigningKeyRequest, ::ControlClient::CreateSigningKeyResponse
      rpc :RevokeSigningKey, ::ControlClient::RevokeSigningKeyRequest, ::ControlClient::RevokeSigningKeyResponse
      rpc :ListSigningKeys, ::ControlClient::ListSigningKeysRequest, ::ControlClient::ListSigningKeysResponse
    end

    Stub = Service.rpc_stub_class
  end
end
