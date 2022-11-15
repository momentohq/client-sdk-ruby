FactoryBot.define do
  factory(
    :momento_response_delete_cache_success,
    class: "Momento::Response::DeleteCache::Success"
  ) do
    momento_response
  end

  factory(
    :momento_response_delete_cache_error_invalid_argument,
    class: "Momento::Response::DeleteCache::Error::InvalidArgument"
  ) do
    momento_response_invalid_argument
  end

  factory(
    :momento_response_delete_cache_error_not_found,
    class: "Momento::Response::DeleteCache::Error::NotFound"
  ) do
    momento_response_not_found
  end

  factory(
    :momento_response_delete_cache_error_permission_denied,
    class: "Momento::Response::DeleteCache::Error::PermissionDenied"
  ) do
    momento_response_permission_denied
  end
end
