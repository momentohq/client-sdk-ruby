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

      rpc :CreateCache, ::ControlClient::_CreateCacheRequest, ::ControlClient::_CreateCacheResponse
      rpc :DeleteCache, ::ControlClient::_DeleteCacheRequest, ::ControlClient::_DeleteCacheResponse
      rpc :ListCaches, ::ControlClient::_ListCachesRequest, ::ControlClient::_ListCachesResponse
      rpc :CreateSigningKey, ::ControlClient::_CreateSigningKeyRequest, ::ControlClient::_CreateSigningKeyResponse
      rpc :RevokeSigningKey, ::ControlClient::_RevokeSigningKeyRequest, ::ControlClient::_RevokeSigningKeyResponse
      rpc :ListSigningKeys, ::ControlClient::_ListSigningKeysRequest, ::ControlClient::_ListSigningKeysResponse
    end

    Stub = Service.rpc_stub_class
  end
end
