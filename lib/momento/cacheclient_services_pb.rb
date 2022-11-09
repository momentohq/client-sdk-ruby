# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: cacheclient.proto for package 'cache_client'

require 'grpc'
require_relative 'cacheclient_pb'

module Momento
  module CacheClient
    module Scs
      class Service

        include ::GRPC::GenericService

        self.marshal_class_method = :encode
        self.unmarshal_class_method = :decode
        self.service_name = 'cache_client.Scs'

        rpc :Get, ::Momento::CacheClient::GetRequest, ::Momento::CacheClient::GetResponse
        rpc :Set, ::Momento::CacheClient::SetRequest, ::Momento::CacheClient::SetResponse
        rpc :Delete, ::Momento::CacheClient::DeleteRequest, ::Momento::CacheClient::DeleteResponse
        rpc :DictionaryGet, ::Momento::CacheClient::DictionaryGetRequest, ::Momento::CacheClient::DictionaryGetResponse
        rpc :DictionaryFetch, ::Momento::CacheClient::DictionaryFetchRequest, ::Momento::CacheClient::DictionaryFetchResponse
        rpc :DictionarySet, ::Momento::CacheClient::DictionarySetRequest, ::Momento::CacheClient::DictionarySetResponse
        rpc :DictionaryIncrement, ::Momento::CacheClient::DictionaryIncrementRequest, ::Momento::CacheClient::DictionaryIncrementResponse
        rpc :DictionaryDelete, ::Momento::CacheClient::DictionaryDeleteRequest, ::Momento::CacheClient::DictionaryDeleteResponse
        rpc :SetFetch, ::Momento::CacheClient::SetFetchRequest, ::Momento::CacheClient::SetFetchResponse
        rpc :SetUnion, ::Momento::CacheClient::SetUnionRequest, ::Momento::CacheClient::SetUnionResponse
        rpc :SetDifference, ::Momento::CacheClient::SetDifferenceRequest, ::Momento::CacheClient::SetDifferenceResponse
        rpc :ListPushFront, ::Momento::CacheClient::ListPushFrontRequest, ::Momento::CacheClient::ListPushFrontResponse
        rpc :ListPushBack, ::Momento::CacheClient::ListPushBackRequest, ::Momento::CacheClient::ListPushBackResponse
        rpc :ListPopFront, ::Momento::CacheClient::ListPopFrontRequest, ::Momento::CacheClient::ListPopFrontResponse
        rpc :ListPopBack, ::Momento::CacheClient::ListPopBackRequest, ::Momento::CacheClient::ListPopBackResponse
        rpc :ListErase, ::Momento::CacheClient::ListEraseRequest, ::Momento::CacheClient::ListEraseResponse
        rpc :ListRemove, ::Momento::CacheClient::ListRemoveRequest, ::Momento::CacheClient::ListRemoveResponse
        rpc :ListFetch, ::Momento::CacheClient::ListFetchRequest, ::Momento::CacheClient::ListFetchResponse
        rpc :ListLength, ::Momento::CacheClient::ListLengthRequest, ::Momento::CacheClient::ListLengthResponse
      end

      Stub = Service.rpc_stub_class
    end
  end
end
