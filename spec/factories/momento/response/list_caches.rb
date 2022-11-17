FactoryBot.define do
  factory(
    :momento_response_list_caches_caches,
    class: "Momento::Response::ListCaches::Caches"
  ) do
    momento_response

    grpc_response {
      build(:momento_control_client_list_caches_response)
    }

    initialize_with {
      Momento::Response::ListCaches::Caches.new(grpc_response)
    }
  end

  factory(
    :momento_response_list_caches_error_permission_denied,
    class: "Momento::Response::ListCaches::Error::PermissionDenied"
  ) do
    momento_response_permission_denied
  end
end
