FactoryBot.define do
  factory(
    :momento_response_delete_cache_deleted,
    class: "Momento::Response::DeleteCache::Deleted"
  ) do
    momento_response
  end

  factory(
    :momento_response_delete_cache_invalid_argument,
    class: "Momento::Response::DeleteCache::InvalidArgument"
  ) do
    momento_response_invalid_argument
  end

  factory(
    :momento_response_delete_cache_not_found,
    class: "Momento::Response::DeleteCache::NotFound"
  ) do
    momento_response_not_found
  end

  factory(
    :momento_response_delete_cache_permission_denied,
    class: "Momento::Response::DeleteCache::PermissionDenied"
  ) do
    momento_response_permission_denied
  end
end
