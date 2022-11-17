FactoryBot.define do
  factory(
    :momento_response_create_cache_error_already_exists,
    class: "Momento::Response::CreateCache::Error::AlreadyExists"
  ) do
    momento_response_already_exists
  end

  factory(
    :momento_response_create_cache_success,
    class: "Momento::Response::CreateCache::Success"
  ) do
    momento_response
  end

  factory(
    :momento_response_create_cache_error_invalid_argument,
    class: "Momento::Response::CreateCache::Error::InvalidArgument"
  ) do
    momento_response_invalid_argument
  end

  factory(
    :momento_response_create_cache_error_permission_denied,
    class: "Momento::Response::CreateCache::Error::PermissionDenied"
  ) do
    momento_response_permission_denied
  end
end
