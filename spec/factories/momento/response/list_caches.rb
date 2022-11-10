FactoryBot.define do
  factory(
    :momento_response_list_caches_caches,
    class: "Momento::Response::ListCaches::Caches"
  ) do
    momento_response
  end

  factory(
    :momento_response_list_caches_permission_denied,
    class: "Momento::Response::ListCaches::PermissionDenied"
  ) do
    momento_response_permission_denied
  end
end
