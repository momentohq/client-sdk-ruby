# frozen_string_literal: true

# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: auth.proto

require 'google/protobuf'

require_relative 'permissionmessages_pb'

descriptor_data = "\n\nauth.proto\x12\x04\x61uth\x1a\x18permissionmessages.proto\"\x0f\n\r_LoginRequest\"\xfc\x02\n\x0e_LoginResponse\x12<\n\x0e\x64irect_browser\x18\x01 \x01(\x0b\x32\".auth._LoginResponse.DirectBrowserH\x00\x12\x32\n\tlogged_in\x18\x02 \x01(\x0b\x32\x1d.auth._LoginResponse.LoggedInH\x00\x12/\n\x07message\x18\x03 \x01(\x0b\x32\x1c.auth._LoginResponse.MessageH\x00\x12+\n\x05\x65rror\x18\x04 \x01(\x0b\x32\x1a.auth._LoginResponse.ErrorH\x00\x1a<\n\x08LoggedIn\x12\x15\n\rsession_token\x18\x01 \x01(\t\x12\x19\n\x11valid_for_seconds\x18\x02 \x01(\r\x1a\x1c\n\x05\x45rror\x12\x13\n\x0b\x64\x65scription\x18\x01 \x01(\t\x1a\x1c\n\rDirectBrowser\x12\x0b\n\x03url\x18\x01 \x01(\t\x1a\x17\n\x07Message\x12\x0c\n\x04text\x18\x01 \x01(\tB\x07\n\x05state\"\xb7\x02\n\x18_GenerateApiTokenRequest\x12\x35\n\x05never\x18\x01 \x01(\x0b\x32$.auth._GenerateApiTokenRequest.NeverH\x00\x12\x39\n\x07\x65xpires\x18\x02 \x01(\x0b\x32&.auth._GenerateApiTokenRequest.ExpiresH\x00\x12\x12\n\nauth_token\x18\x03 \x01(\t\x12\x35\n\x0bpermissions\x18\x04 \x01(\x0b\x32 .permission_messages.Permissions\x12\x10\n\x08token_id\x18\x05 \x01(\t\x12\x13\n\x0b\x64\x65scription\x18\x06 \x01(\t\x1a\x07\n\x05Never\x1a$\n\x07\x45xpires\x12\x19\n\x11valid_for_seconds\x18\x01 \x01(\rB\x08\n\x06\x65xpiry\"j\n\x19_GenerateApiTokenResponse\x12\x0f\n\x07\x61pi_key\x18\x01 \x01(\t\x12\x15\n\rrefresh_token\x18\x02 \x01(\t\x12\x10\n\x08\x65ndpoint\x18\x03 \x01(\t\x12\x13\n\x0bvalid_until\x18\x04 \x01(\x04\"A\n\x17_RefreshApiTokenRequest\x12\x0f\n\x07\x61pi_key\x18\x01 \x01(\t\x12\x15\n\rrefresh_token\x18\x02 \x01(\t\"i\n\x18_RefreshApiTokenResponse\x12\x0f\n\x07\x61pi_key\x18\x01 \x01(\t\x12\x15\n\rrefresh_token\x18\x02 \x01(\t\x12\x10\n\x08\x65ndpoint\x18\x03 \x01(\t\x12\x13\n\x0bvalid_until\x18\x04 \x01(\x04\x32\xe9\x01\n\x04\x41uth\x12\x36\n\x05Login\x12\x13.auth._LoginRequest\x1a\x14.auth._LoginResponse\"\x00\x30\x01\x12U\n\x10GenerateApiToken\x12\x1e.auth._GenerateApiTokenRequest\x1a\x1f.auth._GenerateApiTokenResponse\"\x00\x12R\n\x0fRefreshApiToken\x12\x1d.auth._RefreshApiTokenRequest\x1a\x1e.auth._RefreshApiTokenResponse\"\x00\x42\x42\n\x0cmomento.authP\x01Z0github.com/momentohq/client-sdk-go;client_sdk_gob\x06proto3"

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
  imports = [
    ["permission_messages.Permissions", "permissionmessages.proto"]
  ]
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
  module Auth
    PB__LoginRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("auth._LoginRequest").msgclass
    PB__LoginResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("auth._LoginResponse").msgclass
    PB__LoginResponse::LoggedIn = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("auth._LoginResponse.LoggedIn").msgclass
    PB__LoginResponse::Error = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("auth._LoginResponse.Error").msgclass
    PB__LoginResponse::DirectBrowser = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("auth._LoginResponse.DirectBrowser").msgclass
    PB__LoginResponse::Message = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("auth._LoginResponse.Message").msgclass
    PB__GenerateApiTokenRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("auth._GenerateApiTokenRequest").msgclass
    PB__GenerateApiTokenRequest::Never = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("auth._GenerateApiTokenRequest.Never").msgclass
    PB__GenerateApiTokenRequest::Expires = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("auth._GenerateApiTokenRequest.Expires").msgclass
    PB__GenerateApiTokenResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("auth._GenerateApiTokenResponse").msgclass
    PB__RefreshApiTokenRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("auth._RefreshApiTokenRequest").msgclass
    PB__RefreshApiTokenResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("auth._RefreshApiTokenResponse").msgclass
  end
end