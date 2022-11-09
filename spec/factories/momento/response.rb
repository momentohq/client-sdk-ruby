require 'momento/response'

FactoryBot.define do
  trait :momento_response do
    initialize_with { new }
  end

  trait :momento_response_error do
    grpc_exception { GRPC::BadStatus.new }

    initialize_with { new(grpc_exception: grpc_exception) }
  end

  trait :momento_response_already_exists do
    momento_response_error

    grpc_exception { GRPC::AlreadyExists.new }
  end

  trait :momento_response_invalid_argument do
    momento_response_error

    grpc_exception { GRPC::InvalidArgument.new }
  end

  trait :momento_response_not_found do
    momento_response_error

    grpc_exception { GRPC::NotFound.new }
  end

  trait :momento_response_permission_denied do
    momento_response_error

    grpc_exception { GRPC::PermissionDenied.new }
  end
end
