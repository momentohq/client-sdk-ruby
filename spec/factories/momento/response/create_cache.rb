FactoryBot.define do
  factory(
    :momento_response_create_cache_already_exists,
    class: "Momento::Response::CreateCache::AlreadyExists"
  ) do
    momento_response_already_exists
  end

  factory(
    :momento_response_create_cache_created,
    class: "Momento::Response::CreateCache::Created"
  ) do
    momento_response
  end

  factory(
    :momento_response_create_cache_invalid_argument,
    class: "Momento::Response::CreateCache::InvalidArgument"
  ) do
    momento_response_invalid_argument
  end

  factory(
    :momento_response_create_cache_permission_denied,
    class: "Momento::Response::CreateCache::PermissionDenied"
  ) do
    momento_response_permission_denied
  end
end
