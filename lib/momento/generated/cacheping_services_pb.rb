# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: cacheping.proto for package 'cache_client'

require 'grpc'
require_relative 'cacheping_pb'

module MomentoProtos
  module CacheClient
    module Ping
      class Service
        include ::GRPC::GenericService

        self.marshal_class_method = :encode
        self.unmarshal_class_method = :decode
        self.service_name = 'cache_client.Ping'

        rpc :Ping, ::MomentoProtos::CacheClient::PB__PingRequest, ::MomentoProtos::CacheClient::PB__PingResponse
      end

      Stub = Service.rpc_stub_class
    end
  end
end
