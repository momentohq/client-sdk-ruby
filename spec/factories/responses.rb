require 'momento/response'

FactoryBot.define do
  factory :momento_response, class: "Momento::Response" do
    initialize_with { new }

    factory(:momento_response_success, class: "Momento::Response::Success")

    factory :momento_response_error, class: "Momento::Response::Error" do
      grpc_exception { GRPC::BadStatus.new }

      initialize_with { new(grpc_exception: grpc_exception) }

      factory(
        :momento_response_already_exists,
        class: "Momento::Response::AlreadyExists"
      ) do
        grpc_exception { GRPC::AlreadyExists.new }
      end

      factory(
        :momento_response_invalid_argument,
        class: "Momento::Response::InvalidArgument"
      ) do
        grpc_exception { GRPC::InvalidArgument.new }
      end

      factory(
        :momento_response_not_found,
        class: "Momento::Response::NotFound"
      ) do
        grpc_exception { GRPC::NotFound.new }
      end

      factory(
        :momento_response_permission_denied,
        class: "Momento::Response::PermissionDenied"
      ) do
        grpc_exception { GRPC::PermissionDenied.new }
      end
    end
  end
end
