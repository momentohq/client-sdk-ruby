require 'momento/response'

FactoryBot.define do
  trait :momento_response do
    initialize_with { new(**attributes) }
  end

  trait :momento_response_error do
    momento_response

    grpc_exception { GRPC::PermissionDenied.new }
  end
end
