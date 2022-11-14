FactoryBot.define do
  factory(
    :momento_response_get_hit,
    class: "Momento::Response::Get::Hit"
  ) do
    transient do
      value { Faker::Lorem.sentence }
    end

    momento_response_success

    grpc_response {
      build(:momento_cache_client_get_response, :hit, cache_body: value)
    }
  end

  factory(
    :momento_response_get_miss,
    class: "Momento::Response::Get::Miss"
  ) do
    momento_response
  end

  factory(
    :momento_response_get_invalid_argument,
    class: "Momento::Response::Get::InvalidArgument"
  ) do
    momento_response_invalid_argument
  end

  factory(
    :momento_response_get_permission_denied,
    class: "Momento::Response::Get::PermissionDenied"
  ) do
    momento_response_permission_denied
  end
end
